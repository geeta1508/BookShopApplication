import category_op as cat
import book_op as book
import admin
import user
from main import app
# ---------------------------------admin------------------------------------------
app.add_url_rule("/showAllCategory",view_func=cat.showAllCategory) #1.url,2.method
app.add_url_rule("/addCategory",view_func=cat.addCategory,methods=["GET","POST"])
app.add_url_rule("/delete/<cid>",view_func=cat.deleteCategory,methods=["GET","POST"])
app.add_url_rule("/edit/<cid>",view_func=cat.editCategory,methods=["GET","POST"])

app.add_url_rule("/showAllbooks",view_func=book.showAllbooks)
app.add_url_rule("/addbook",view_func=book.addbook,methods=["GET","POST"])
app.add_url_rule("/delete_book/<book_id>",view_func=book.deletebook,methods=["GET","POST"])
app.add_url_rule("/edit_book/<book_id>",view_func=book.editbook,methods=["GET","POST"])
app.add_url_rule("/adminlogin",view_func=admin.adminlogin,methods=["GET","POST"])
app.add_url_rule("/adminHome",view_func=admin.adminHome)
app.add_url_rule("/adminLogout",view_func=admin.adminLogout)
#--------------------------------user-----------------------------------------------
app.add_url_rule("/",view_func=user.homepage)
app.add_url_rule("/ShowBooks/<cid>",view_func= user.ShowBooks)
app.add_url_rule("/ViewDetails/<bookid>",view_func=user.ViewDetails,methods=["GET","POST"])
app.add_url_rule("/register",view_func=user.register,methods=["GET","POST"])
app.add_url_rule("/login",view_func=user.login,methods=["GET","POST"])
app.add_url_rule("/logout",view_func=user.logout)
app.add_url_rule("/showCart",view_func=user.showCart,methods=["GET","POST"])
app.add_url_rule("/MakePayment",view_func=user.MakePayment,methods=["GET","POST"])
app.add_url_rule("/showOrder",view_func=user.showOrder)