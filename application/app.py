import mysql.connector
from mysql.connector import Error
from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

def testConnection(host,username,password,database,port):

    status        = False #connection status

    try:
        connection = mysql.connector.connect(host=host,
                                         database=database,
                                         user=username,
                                         password=password,
                                         port=port)
        if connection.is_connected():
            status = True
            db_Info = connection.get_server_info()
            print("Connected to MySQL Server version ", db_Info)
            cursor = connection.cursor()
            cursor.execute("select database();")
            record = cursor.fetchone()
            msg = f"You're connected to database : {record}"
            
    except Error as e:
        msg = f"Error while connecting to database : {e}"

    finally:
        if status:
            cursor.close()
            connection.close()

    return msg


@app.route('/')
def home():
    return render_template('home.html')

@app.route('/result', methods=['GET', 'POST'])
def result():
    if request.method == 'POST':
        host        = request.form['host']
        username    = request.form['username']
        password    = request.form['password']
        database    = request.form['database']
        port        = request.form['port']
        return testConnection(host,username,password,database,port)
    else:
        return redirect(url_for("home"))

if __name__ == "__main__":
    app.run(host='0.0.0.0')
