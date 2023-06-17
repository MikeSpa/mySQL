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

# Let's close the cursor and the connection
if connection.is_connected():
    cursor.close()
    print("The cursor is closed.")
    connection.close()
    print("MySQL connection is closed.")
else:
    print("Connection is already closed")
```

## INSERT

```py
insert_orders="""
INSERT INTO Orders (OrderID, TableNo, MenuID, BookingID, Quantity, BillAmount)
VALUES
(1, 12, 1, 1, 2, 86),
(2, 19, 2, 2, 1, 37),
(3, 15, 2, 3, 1, 37),
(4, 5, 3, 4, 1, 40),
(5, 8, 1, 5, 1, 43);"""

print("Inserting data in MenuItems table.")
# Populate MenuItems table
cursor.execute(insert_menuitmes)
print("Total number of rows in MenuItem table: ", cursor.rowcount)
# Once the query is executed, you commit the change into the database 
connection.commit()
```

## READ

```py
# Read query is:
all_bookings = """SELECT GuestFirstName, GuestLastName, 
TableNo FROM Bookings;"""

# Eexecute query 
cursor.execute(all_bookings)

# Fetch all results that satisfy the query 
results = cursor.fetchall()

# Retrieve column names
cols = cursor.column_names

# Print column names and records from results using for loop
print("""Data in the "Bookings" table:""")
print(cols)
for result in results:
    print(result)
```

## Update

```py
# The update query is:
update_bookings="""UPDATE Bookings
SET TableNo=10
WHERE BookingID = 6;"""

# Execute the query to update the table
print("Executing update query")
cursor.execute(update_bookings)

# Commit change 
print("Comitting change to the table")
connection.commit()
print("Record is updated in the table")
```

## Delete

```py
# The SQL query is:
delete_query_greek="""DELETE FROM Menus WHERE Cuisine = 'Greek'"""

# Execute the query
print("Executing 'DELETE' query")
cursor.execute(delete_query_greek)

# Commit change 
print("Comitting change to the table")
connection.commit()
print("The table is updated after deletion of the requested records")
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