from flask import Flask, url_for, render_template, request , Response, redirect
import pymysql
import io
import sys
import string
import datetime
import platform

from pymysql import escape_string

app = Flask(__name__)
conn = pymysql.connect(
        host='8.210.44.191',
        port=3306,
        user='virtualman',
        passwd='******',
        db='virtualblog',
        charset='utf8',
    )


def transferContent(self, content):
    if content is None:
        return None
    else:
        string = ""
        for c in content:
            if c == '"':
                string += '\\\"'
            elif c == "'":
                string += "\\\'"
            elif c == "\\":
                string += "\\\\"
            else:
                string += c
        return string
def GetFrinends():
    friends = SendSQL("SELECT * FROM `virtualblog`.`virtual_friends` LIMIT 0,1000")
    return friends
def SendSQL(sql):
    cursor = conn.cursor()

    cursor.execute(sql)
    results = cursor.fetchall()  # 接受返回结果行
    # for row in results:
    cursor.close()
    return results

def GetAllArticles():
    title = list()
    content = list()

    ans = SendSQL("SELECT * FROM `virtualblog`.`virtual_articles` "+"order by article_id desc")
    return ans

def iflogin():
    resp = Response()
    #print(request.cookies.get('user_name'))
    if request.cookies.get('username') == None:
        print("未登陆，请先登录")
        return False
    else:
        return True


def GetAllArticleClass():
    res = list()
    ans = SendSQL("SELECT * FROM `virtualblog`.`virtual_sort` LIMIT 0,1000")
    for row in ans:
        res.append(row[1])
    return res
@app.route('/index')
@app.route('/',methods=['GET'])
def index():
    if request.args.get('exit')=='1':
        response = redirect(url_for('index'))

        response.delete_cookie('username')
        response.delete_cookie('userid')
    friends = GetFrinends()
    user_name = request.cookies.get('username')
    time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    artistclass = GetAllArticleClass()
    artists = GetAllArticles()
    return render_template('index.html', **locals())
    # **locals()

@app.route('/about')
def about():
    friends = GetFrinends()
    user_name = request.cookies.get('username')
    time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    artistclass = GetAllArticleClass()
    artists = GetAllArticles()

    return render_template('about.html', **locals())
@app.route('/article',methods=['GET','POST'])
def article():
    friends = GetFrinends()
    user_name = request.cookies.get('username')
    time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    artistclass = GetAllArticleClass()
    artists = GetAllArticles()

    article_id = request.args.get("article_id")
    res = SendSQL("SELECT * FROM `virtualblog`.`virtual_articles` WHERE `article_id` = '"+article_id+"' LIMIT 0,1000")
    print(res)
    for i in res:
        id = i[0]
        article_title = i[1]
        article_content = i[2]
        article_user = 'Virtualman'
        article_datatime = i[5]
        article_views = i[3]
        article_comment_count=i[4]
        article_like_count = i[6]
    article_views=article_views+1
    SendSQL("UPDATE `virtualblog`.`virtual_articles` SET `article_views` = "+str(article_views)+" WHERE `article_id` = "+str(id))



    if request.method=='POST':
        article_id = request.args.get("article_id")
        user_name = request.form.get('user_name')
        # comment_mail
        comment_mail = request.form.get('comment_mail')
        comment_url = request.form.get('comment_url')
        comment_time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        comment_content =transferContent(request.form.get('comment_content'))
        sql = "INSERT INTO `virtualblog`.`virtual_comment`(`comment_user_name`, `comment_article_id`, `comment_datatime`, `comment_content`, `comment_mail`, `comment_url`) VALUES ('"+user_name+"', "+str(article_id)+", '"+str(comment_time)+"', '"+comment_content+"', '"+comment_mail+"', '"+comment_url+"')"
        SendSQL(sql)
        article_comment_count = article_comment_count + 1
        SendSQL("UPDATE `virtualblog`.`virtual_articles` SET `article_comment_count` = " + str(article_comment_count) + " WHERE `article_id` = " + str(id))

    # 显示评论：
    sql = "SELECT * FROM `virtualblog`.`virtual_comment` WHERE `comment_article_id` = '" + str(
        id) + "' LIMIT 0,1000"
    comments = SendSQL(sql)
    return render_template('article.html', **locals())

@app.route('/admin')

@app.route('/admin/editor',methods=['POST','GET'])
def admin_ediotr():
    friends = GetFrinends()
    user_name = request.cookies.get('username')
    if iflogin() == False:
        return redirect(url_for('admin_login'))

    artistclass = GetAllArticleClass()
    sortclass = SendSQL("SELECT * FROM `virtualblog`.`virtual_sort` ")

    if request.method == 'GET':
        if request.args.get('article_id')!=None:
            res = SendSQL("SELECT * FROM `virtualblog`.`virtual_articles` WHERE `article_id` = '"+request.args.get('article_id')+"' LIMIT 0,1000")
            article_title = res[0][1]
            article_time = res[0][5]
            article_content = res[0][2]
            article_sortid = res[0][7]
            return render_template('editor.html', **locals())

    if request.method == 'POST':
        article_title = request.form.get('title')
        article_time = request.form.get('time')
        article_content = request.form.get('content')
        article_sortid = request.form.get('sortid')
        #print(article_title, article_time, article_content)
        if request.args.get('article_id') == None:
            ans = SendSQL("INSERT INTO `virtualblog`.`virtual_articles`(`article_title`, `article_content`, `article_datatime`,`article_class_id`) VALUES ('"+escape_string(article_title)+"','"+escape_string(article_content)+"', '"+article_time+"','"+str(article_sortid)+"')")
        else:
            ans = SendSQL("UPDATE `virtualblog`.`virtual_articles` SET `article_title` = '"+escape_string(article_title)+"', `article_content` = '"+escape_string(article_content)+"', `article_datatime` = '"+article_time+"', `article_class_id` = '"+str(article_sortid)+"' WHERE `article_id` = "+request.args.get("article_id"))
        #print(ans)
        message = '文章发布成功'
        return render_template('editor.html', **locals())
    else:
        return render_template('editor.html', **locals())


@app.route('/articleClass',methods=['POST','GET'])
def articleClass():
    friends = GetFrinends()
    user_name = request.cookies.get('username')
    time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    artistclass = GetAllArticleClass()
    artists = GetAllArticles()

    classname = request.args.get('classname')
    res = SendSQL("SELECT * FROM `virtualblog`.`virtual_sort` WHERE `sort_name` LIKE '%s' " % classname)
    sort_id = res[0][0]
    artists = SendSQL("SELECT * FROM `virtualblog`.`virtual_articles` WHERE `article_class_id` = '"+str(sort_id)+"' LIMIT 0,1000")
    return render_template('articelClass.html', **locals())

@app.route('/admin/article_list',methods=['POST','GET'])
def article_list():
    friends = GetFrinends()
    user_name = request.cookies.get('username')
    if iflogin() == False:
        return redirect(url_for('admin_login'))
    time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    artistclass = GetAllArticleClass()
    if request.method == 'GET':
        delete_id = request.args.get('delete_id')
        if str(delete_id) != 'None':
            message = '文章及其评论删除成功！'
            SendSQL("DELETE FROM `virtualblog`.`virtual_articles` WHERE `article_id` = "+str(delete_id))
            SendSQL("DELETE  FROM `virtualblog`.`virtual_comment` WHERE `comment_article_id` = "+str(delete_id))
    artists = GetAllArticles()
    return render_template('article_list.html', **locals())

@app.route('/admin/login',methods=['POST','GET'])
def admin_login():

    user_name = request.cookies.get('username')
    if request.method=='POST':
        user_name = request.form.get('username')
        password = request.form.get('Password')
        res = SendSQL("SELECT * FROM `virtualblog`.`virtual_users` WHERE `user_name` = '"+user_name+"' AND `user_password` = '"+password+"' LIMIT 0,1000")
        print(str(res))
        if(str(res)!='()'):
            user_id = res[0][0]
            message = '登陆成功'
            response = redirect(url_for('admin_ediotr'))

            response.set_cookie('username',user_name, max_age=2600)
            response.set_cookie('userid',str(user_id),max_age=2600)
            return response
        else:
            message = '登陆失败'
    return render_template('admin_login.html', **locals())
@app.route('/admin/comments',methods=['POST','GET'])
def delent_comments():
    friends = GetFrinends()
    user_name = request.cookies.get('username')
    if iflogin() == 0:
        render_template("admin_login.html", **locals())
    id = request.args.get('delete_id')
    if(id!=None):
        SendSQL("DELETE FROM `virtualblog`.`virtual_comment` WHERE `comment_id` = "+str(id))
        message = "评论删除成功"

    comments = SendSQL("SELECT * FROM `virtualblog`.`virtual_comment`")

    return render_template('admin_comments_list.html', **locals())
@app.route('/admin/class_list',methods=['POST','GET'])
def class_list():
    friends = GetFrinends()
    user_name = request.cookies.get('username')
    id = request.args.get('delete_id')
    if (id != None):
        SendSQL("DELETE FROM `virtualblog`.`virtual_sort` WHERE `sort_id` = " + str(id))
        message = "分类删除成功"

    classsort= SendSQL("SELECT * FROM `virtualblog`.`virtual_sort` LIMIT 0,1000")
    return render_template('admin_classsort.html', **locals())
@app.route('/admin/editor/newclass',methods=['POST','GET'])
def add_new_sort():
    user_name = request.cookies.get('username')
    if iflogin() == False:
        return redirect(url_for('admin_login'))
    title = request.form.get("title")
    if title!=None:
        SendSQL("INSERT INTO `virtualblog`.`virtual_sort`(`sort_name`) VALUES ('"+title+"')")
    return render_template("admin_new_sort.html",**locals())


@app.route('/admin/editor/newfriends',methods=['POST','GET'])
def add_newfriends():
    friends = GetFrinends()
    user_name = request.cookies.get('username')
    if iflogin() == False:
        return redirect(url_for('admin_login'))
    name = request.form.get("name")
    url  =request.form.get("url")
    if name!=None and url!=None:
        SendSQL("INSERT INTO `virtualblog`.`virtual_friends`(`friends_name`, `friends_url`) VALUES ('"+name+"', '"+url+"')")



    return render_template("admin_newfriends.html",**locals())



if __name__ == '__main__':
    sysstr = platform.system()
    if (sysstr == "Windows"):
        app.debug=True
    elif (sysstr == "Linux"):
        app.debug=False
    if(app.debug==True):
        app.run()
    else:
        app.run('0.0.0.0', port=80)
