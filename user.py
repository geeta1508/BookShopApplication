from flask import Flask, render_template,redirect,request,session
import mysql.connector
from datetime import datetime

def homepage():
    con=mysql.connector.connect(host="localhost",username="root",password="1508",database="bookshopApplication")
    cursor=con.cursor()
    sql="select * from category;"
    cursor.execute(sql)
    cats= cursor.fetchall()
    sql="select * from book;"
    cursor.execute(sql)
    books= cursor.fetchall()
    return render_template("user/homepage.html",cats=cats,books=books)

def ShowBooks(cid):
    con=mysql.connector.connect(host="localhost",username="root",password="1508",database="bookshopApplication")
    cursor=con.cursor()
    sql="select * from category;"
    cursor.execute(sql)
    cats= cursor.fetchall()
    sql="select * from Book where cid=%s"
    val=(cid,)
    cursor.execute(sql,val)
    books= cursor.fetchall()

    sql="select cname from Category where cid=%s"
    val=(cid,)
    cursor.execute(sql,val)
    catname=cursor.fetchone()[0]
    return render_template("user/homepage.html",cats=cats,books=books,catname=catname)


def ViewDetails(bookid):
    con=mysql.connector.connect(host="localhost",username="root",password="1508",database="bookshopApplication")
    cursor=con.cursor()
    if request.method=="GET":
       sql="select * from category"
       cursor.execute(sql)
       cats= cursor.fetchall()
       sql="select * from book_cat_vw where book_id=%s"
       val=(bookid,)
       cursor.execute(sql,val)
       book=cursor.fetchone()
       return render_template("user/viewdetails.html",cats=cats,book=book)
    else:
        if "uname" in session:
            uname=session["uname"]
            book_id=request.form["bid"]
            qty=request.form["qty"]
            sql="insert into mycart (book_id,qty,status,username) values (%s,%s,%s,%s)"
            val=(book_id,qty,'cart',uname)
            cursor.execute(sql,val)
            con.commit()
            return redirect("/showCart")
        else:
            return redirect("/login")

def register():
    con=mysql.connector.connect(host="localhost",username="root",password="1508",database="bookshopApplication")
    cursor=con.cursor()
    if request.method=="GET":
        sql="select * from category"
        cursor.execute(sql)
        cats= cursor.fetchall()
        return render_template("user/register.html",cats=cats)
    else:
        uname=request.form["uname"]
        pwd =request.form["pwd"]
        email=request.form["email"]
        sql="insert into userinfo values (%s,%s,%s)"
        val=(uname,pwd,email)
        try:
           cursor.execute(sql,val)
           con.commit()
           return redirect("/")
        except:
           return redirect("/register")
        
def login():
    con=mysql.connector.connect(host="localhost",username="root",password="1508",database="bookshopApplication")
    cursor=con.cursor()
    if request.method=="GET":
       sql="select * from category"
       cursor.execute(sql)
       cats= cursor.fetchall()
       return render_template("user/login.html",cats=cats)
    else:
        uname=request.form["uname"]
        pwd =request.form["pwd"]
        con=mysql.connector.connect(host="localhost",username="root",password="1508",database="bookshopApplication")
        cursor=con.cursor()
        sql="select count(*) from userinfo where username=%s and password=%s"
        val=(uname,pwd)
        cursor.execute(sql,val)
        count=int (cursor.fetchone()[0])
        if count==1:
           session["uname"]=uname
           return redirect("/")
        else:
           return redirect("/register")        

def logout():
    session.clear()
    return redirect("/")
            
def showCart():
    con=mysql.connector.connect(host="localhost",username="root",password="1508",database="bookshopApplication")
    cursor=con.cursor()
    if request.method=="GET":
        if "uname" in session: #user has logged in
           con=mysql.connector.connect(host="localhost",username="root",password="1508",database="bookshopApplication")
           cursor=con.cursor()
           sql="select * from category"
           cursor.execute(sql)
           cats= cursor.fetchall()
           sql= "select * from cart_vw where username= %s"
           val= (session["uname"],)
           cursor.execute(sql,val)
           items=cursor.fetchall()
           sql= "select sum(Subtotal) from cart_vw where username=%s"
           cursor.execute(sql,val)
           total=cursor.fetchone()[0]
           session["total"]=total
           return render_template("user/showCart.html",items=items,total=total,cats=cats)
        else:
            return redirect("/login")
    else:
        action=request.form['action']
        cart_id=request.form['cart_id']
        if action=="edit":
            qty=request.form['qty']
            sql="update mycart set qty=%s where cart_id=%s"
            val=(qty,cart_id)
            cursor.execute(sql,val)
            con.commit()
        else:
            sql="delete from mycart where cart_id=%s"
            val=(cart_id,)
            cursor.execute(sql,val)
            con.commit()
        return redirect("/showCart")   

def MakePayment():
    if request.method=="GET":
        return render_template("user/MakePayment.html")
    else:
        cardno=request.form["cardno"] 
        cvv=request.form["cvv"]
        expiry=request.form["expiry"]
        con = mysql.connector.connect(host="localhost",username="root",password="1508",database="bookshopapplication")
        cursor = con.cursor()
        sql="select count(*) from payment where cardno=%s and cvv=%s and expiry=%s"
        val=(cardno,cvv,expiry)
        cursor.execute(sql,val)
        count=int(cursor.fetchone()[0])
        if count == 1: #user cartdetails are valid
            sql1="update payment set balance=balance+%s where cardno=%s" #owner
            val1=(session["total"],"5555")
            sql2="update payment set balance=balance-%s where cardno=%s" #buyer
            val2=(session["total"],cardno)
            cursor.execute(sql1,val1)
            cursor.execute(sql2,val2)
            # #update card table
            # sql="update mycart set status='order' where username=%s"
            # val=(session["uname"],)
            # cursor.execute(sql,val)
            # con.commit()
            sql="insert into order_master (date_of_order,amount,username) values (%s,%s,%s)"
            val=(datetime.now(),session['total'],session['uname'])
            cursor.execute(sql,val)
            con.commit()  
            dd=datetime.today().strftime('%Y-%m-%d')
            sql="select order_id from order_master where date_of_order=%s and amount=%s and username=%s"
            val=(dd,session['total'],session['uname'])
            print(val)
            cursor.execute(sql,val) 
            oid=cursor.fetchone()[0]
            sql="update mycart set status='order',order_id=%s where status='cart' and username=%s"
            val=(oid,session['uname'])
            cursor.execute(sql,val)
            con.commit()
            return redirect("/")
        else:
            return redirect("/MakePayment")
        
def showOrder():
    con = mysql.connector.connect(host="localhost",username="root",password="1508",database="bookshopapplication")
    cursor = con.cursor()      
    sql="select * from order_vw where username=%s"
    val=(session['uname'],)
    cursor.execute(sql,val) 
    order_details=cursor.fetchall()

    sql="select * from order_master where username=%s"
    val=(session['uname'],)
    cursor.execute(sql,val) 
    order=cursor.fetchall()

    sql = "select * from category"
    cursor.execute(sql)
    cats = cursor.fetchall()
    return render_template("user/showOrder.html",order_details=order_details,order=order,cats=cats)
                