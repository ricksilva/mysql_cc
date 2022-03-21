import mysql.connector

conn = mysql.connector.connect(
    user='top_app',
	password='pQ3fgR5u5',
	host='localhost',
	database='topography')
	
cursor = conn.cursor()

cursor.execute('select mountain_name, location, height from mountain')

for (mountain, location, height) in cursor:
    print(mountain, location, height)

cursor.close()
conn.close()
