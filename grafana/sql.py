from datetime import date, datetime, timedelta
import mysql.connector as sql
import names

createEmployeesTable = (
    "CREATE TABLE `employees` ("
    "  `emp_no` int(11) NOT NULL AUTO_INCREMENT,"
    "  `birth_date` date NOT NULL,"
    "  `first_name` varchar(14) NOT NULL,"
    "  `last_name` varchar(16) NOT NULL,"
    "  `gender` enum('M','F') NOT NULL,"
    "  `hire_date` date NOT NULL,"
    "  PRIMARY KEY (`emp_no`)"
    ") ENGINE=InnoDB")

add_employee = ("INSERT INTO employees "
               "(first_name, last_name, hire_date, gender, birth_date) "
               "VALUES (%s, %s, %s, %s, %s)")

tomorrow = datetime.now().date() + timedelta(days=1)


db = sql.connect(
    user="root",
    password="qweasd",
    host="127.0.0.1",
    database="test"
)
cursor = db.cursor()

# cmd = createEmployeesTable
# cursor.execute(cmd)
for i in range(100):
    data_employee = (names.get_first_name(), names.get_last_name(), tomorrow, 'M', date(1977, 6, 14))
    cursor.execute(add_employee, data_employee)

db.commit()

cursor.close()
db.close()