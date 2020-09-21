from datetime import date, datetime, timedelta
import mysql.connector as sql
import time
import pytz
import random
add_block = (
    "insert into metric"
    "(time,tps)"
    "values(%s,%s)"
    )

db = sql.connect(
    user="root",
    password="qweasd",
    host="127.0.0.1",
    database="grafana"
)
cursor = db.cursor()

i = 0
while True:
    data = (datetime.now(tz=pytz.timezone('UTC')),1000*random.randint(1,100)*random.random())
    print(data)
    time.sleep(5)
    cursor.execute(add_block,data)
    i+=1
    db.commit()


cursor.close()
db.close()