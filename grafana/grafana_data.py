from datetime import date, datetime, timedelta
import mysql.connector as sql
import names

add_employee = ("INSERT INTO data "
               "(first_name, last_name, hire_date, gender, birth_date) "
               "VALUES (%s, %s, %s, %s, %s)")

add_block = (
    "insert into metric"
    "(time,tps)"
    "values(%s,%s)"
    )

tomorrow = datetime.now().date() + timedelta(days=1)

db = sql.connect(
    user="root",
    password="qweasd",
    host="127.0.0.1",
    database="grafana"
)
cursor = db.cursor()

for i in range(100):
    data_employee = (names.get_first_name(), names.get_last_name(), tomorrow, 'M', date(1977, 6, 14))
    cursor.execute(add_employee, data_employee)

for i in range(100):
    data = (datetime.now(),1000*i)
    cursor.execute(add_block,data)

db.commit()

cursor.close()
db.close()