import mysql.connector as sql

db = sql.connect(
    user="root",
    password="qweasd",
    host="127.0.0.1"
)
cursor = db.cursor()

createDataTable = (
    "CREATE TABLE `data` ("
    "  `emp_no` int(11) NOT NULL AUTO_INCREMENT,"
    "  `birth_date` date NOT NULL,"
    "  `first_name` varchar(14) NOT NULL,"
    "  `last_name` varchar(16) NOT NULL,"
    "  `gender` enum('M','F') NOT NULL,"
    "  `hire_date` date NOT NULL,"
    "  PRIMARY KEY (`emp_no`)"
    ") ENGINE=InnoDB")

createMetricData = (
    "CREATE TABLE `metric` ("
    "  `number` int(11) NOT NULL AUTO_INCREMENT,"
    "  `time` datetime NOT NULL,"
    "  `tps` int(11) NOT NULL,"
    "  PRIMARY KEY (`number`)"
    ") ENGINE=InnoDB")


init_grafana_db = [
    "create database grafana;",
    "use grafana",
    "CREATE USER 'grafana' IDENTIFIED BY 'qweasd';",
    createMetricData,
    createDataTable,
    "GRANT SELECT ON grafana.* TO 'grafana';"
    "flush PRIVILEGES;"
]

for cmd in init_grafana_db:
    print(cmd)
    cursor.execute(cmd)

cursor.close()
db.close()

