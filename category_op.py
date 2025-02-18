from flask import Flask,render_template,redirect,request
import mysql.connector


def showAllCategory():
    con=mysql.connector.connect(host="localhost",username="root",password="1508",database="bookshopapplication")
    cursor=con.cursor()
    sql="Select * from Category"
    cursor.execute(sql)
    cats= cursor.fetchall()
    return render_template("Category/showAllCategory.html",cats=cats)


def addCategory():
    if request.method == "GET":
        return render_template("Category/addCategory.html")
    else:
       con=mysql.connector.connect(host="localhost",username="root",password="1508",database="bookshopApplication")
       cursor=con.cursor() 
       sql="insert into Category (cname) values (%s)"
       val= (request.form["cname"],)
       cursor.execute(sql,val)
       con.commit()
    return redirect("/showAllCategory") 

def deleteCategory(cid):
    if request.method == "GET":
        return render_template("Category/deleteCategory.html")
    else:    
        action=request.form["action"]
        if action=="Yes":
            con=mysql.connector.connect(host="localhost",username="root",password="1508",database="bookshopApplication")
            cursor=con.cursor() 
            sql="delete from category where cid=%s"
            val= (cid,)
            cursor.execute(sql,val)
            con.commit()
        return redirect("/showAllCategory") 
    

def editCategory(cid):
      
    con = mysql.connector.connect(host="localhost",username="root",password="1508",database="bookshopApplication")
    cursor = con.cursor()        
    if request.method == "GET":
        sql = "select * from category where cid=%s"    
        val = (cid,)
        cursor.execute(sql,val)
        category = cursor.fetchone() 
        return render_template("Category/editCategory.html",category=category)    
    else:
        cname = request.form['cname']
        sql="update category set cname=%s where cid=%s "
        val=(cname,cid)
        cursor.execute(sql,val)
        con.commit()
        return redirect("/showAllCategory")     

