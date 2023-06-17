# MySQL Connector


## Connect to MySQL
```python
# Import MySQL Connector/Python 
import mysql.connector as connector


# Connect to the database
try:
    print("Establishing a new connection between MySQL and Python.")
    connection=connector.connect(user="root",password=db_pass)
    print("A connection between MySQL and Python is successfully established")

except connector.Error as er:
    print("Error code:", er.errno)
    print("Error message:", er.msg)
connection=connector.connect(user="root",password=db_pass)


# Create a cursor object to communicate with entire MySQL database
cursor = connection.cursor()

```
## Create a databse
```py
# Create database and checking all that we have!

cursor.execute("CREATE DATABASE little_lemon")
cursor.execute("SHOW DATABASES")
for database in cursor:
    print(database)

# Set little_lemon database for use 
cursor.execute("USE little_lemon")

# Confirm the database in use
connection.database
```

## Create Table

```py
# The SQL query for MenuItems table is: 
create_menuitem_table="""
CREATE TABLE MenuItems (
ItemID INT AUTO_INCREMENT,
Name VARCHAR(200),
Type VARCHAR(100),
Price INT,
PRIMARY KEY (ItemID)
);"""

# Create MenuItems table
cursor.execute(create_menuitem_table)

# Confirm if the table is created
cursor.execute("SHOW TABLES")
for table in cursor:
    print(table)
```

## Working with cursors


```py
# Create a cursor object to communicate with entire MySQL database
cursor = connection.cursor()
cursor.execute("""USE little_lemon""")
cursor.execute("""SHOW TABLES;""")
results = cursor.fetchall()
for table in results:
    print(table)

# Need Buffered cursor if multiple SELECT:
cursor = connection.cursor(buffered = True)

# Set the “little_lemon” database for use
cursor.execute("""USE little_lemon;""")
print("The little_lemon database is set for use.")

# Retrieve records from bookings
cursor.execute("""SELECT * FROM Bookings;""")
print("All records from Bookings table are retrieved.")

# Retrieve records from orders
cursor.execute("""SELECT * FROM Orders;""")
print("All records from Orders table are retrieved.")

# Dictionary cursor
# Create a cursor object with dictionary=True
dic_cursor=connection.cursor(dictionary=True)
type(cursor)
```



## Close connection

```py
# Let's close the cursor and the connection
if connection.is_connected():
    cursor.close()
    print("The cursor is closed.")
    connection.close()
    print("MySQL connection is closed.")
else:
    print("Connection is already closed")
```



default port for a MySQL database is 3306.