from flask import Flask,render_template,redirect,request,session
import mysql.connector

def adminlogin():
    if request.method=="GET":
        return render_template("admin/login.html")
    else:
        uname=request.form["uname"]
        pwd=request.form["pwd"]
        sql="select count(*) from adminuser where username=%s and password=%s"
        val=(uname,pwd)
        con=mysql.connector.connect(host="localhost",username="root",password="1508",database="bookshopApplication")
        cursor=con.cursor()
        cursor.execute(sql,val)
        count=cursor.fetchone()
        count=int(count[0])
        if count == 1:
            session["uname"]=uname
            return redirect("/adminHome")
        else:
            return redirect("/adminlogin")
        
def adminHome():
    if "uname" in session:
        return render_template("admin/adminHome.html")
    else:
        return redirect("/adminlogin")
    
def adminLogout():
    session.clear()
    return redirect("/adminlogin")   