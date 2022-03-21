import mysql.connector

conn = mysql.connector.connect(
    user='top_app',
    password='pQ3fgR5u5',
    host='localhost',
    database='topography')
	
cursor = conn.cursor(prepared=True)

sql = "insert into mountain(mountain_name, location, height) values (?,?,?)"
val = ("Ojos Del Salado", "South America", 22615)
cursor.execute(sql, val)
conn.commit()

cursor.close()
conn.close()
