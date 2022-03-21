import mysql.connector

conn = mysql.connector.connect(
    user='top_app',
    password='pQ3fgR5u5',
    host='localhost',
    database='topography')

cursor = conn.cursor()

cursor.callproc('p_get_mountain_by_loc', ['Asia'])

for results in cursor.stored_results():
    for record in results:
        print(record[0], record[1])

cursor.close()
conn.close()
