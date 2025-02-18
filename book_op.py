from flask import Flask, render_template,redirect,request
import mysql.connector
from werkzeug.utils import secure_filename


def showAllbooks():
    con=mysql.connector.connect(host="localhost",username="root",password="1508",database="bookshopApplication")
    cursor=con.cursor()
    sql="select * from book_cat_vw;"
    cursor.execute(sql)
    books= cursor.fetchall()
    return render_template("book/showAllbooks.html",books=books)

def addbook():
    con=mysql.connector.connect(host="localhost",username="root",password="1508",database="bookshopApplication")
    cursor=con.cursor()
 
    if request.method == "GET":
       sql="select * from category"
       cursor.execute(sql) 
       cats=cursor.fetchall()
       return render_template("book/addbook.html",cats=cats)
    else:
       cname=request.form["cname"]
       price=request.form["price"]
       description=request.form["description"]
       cid=request.form["cat"]
       f=request.files['image_url']
       filename= secure_filename(f.filename)
       filename= "static/Images/"+f.filename
       #this will save file to the specified location
       f.save(filename)
       filename="Images/"+f.filename
       sql="insert into book (book_name,price,description,image_url,cid) values (%s,%s,%s,%s,%s)"
       val= (cname,price,description,filename,cid)
       cursor.execute(sql,val)
       con.commit()
       return redirect("/showAllbooks") 

    
def deletebook(book_id):
    if request.method == "GET":
        return render_template("book/deletebook.html")
    else:    
        action=request.form["action"]
        if action=="Yes":
            con=mysql.connector.connect(host="localhost",username="root",password="1508",database="bookshopApplication")
            cursor=con.cursor() 
            sql="delete from book where book_id=%s"
            val= (book_id,)
            cursor.execute(sql,val)
            con.commit()
        return redirect("/showAllbooks") 
    
def editbook(book_id):
    con=mysql.connector.connect(host="localhost",username="root",password="1508",database="bookshopApplication")
    cursor=con.cursor() 
    if request.method == "GET":
        sql="select * from book where book_id=%s"
        val= (book_id,)
        cursor.execute(sql,val)
        book=cursor.fetchone()
        return render_template("book/editbook.html",book=book)
    else:    
       book_name=request.form['book_name']
       #discription=request.form['discription']
       sql="update book set book_name=%s where book_id=%s"
       val=(book_name,book_id)
       cursor.execute(sql,val)    
       con.commit()
    return redirect("/showAllbooks") 
       