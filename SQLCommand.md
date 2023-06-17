# Common SQL Commands

CREATE TABLE table_name (column_name1 datatype(size), column_name2 datatype(size), column_name3 datatype(size));  
DROP TABLE table_name;   
ALTER TABLE table_name ADD (column_name datatype(size));  
ALTER TABLE table_name ADD primary key (column_name);  
TRUNCATE TABLE table_name;  
--Retrieve all data from a table  
SELECT * FROM table_name;  
INSERT INTO table_name (column1, column2, column3) VALUES (value1, value2, value3);  
UPDATE table_name SET column1 = value1, column2 = value2 WHERE condition;  
DELETE FROM table_name WHERE condition;  

## Examples
CREATE TABLE customers(CustomerId INT, FirstName VARCHAR(40), LastName VARCHAR(20), Company VARCHAR(80), Address VARCHAR(70), City VARCHAR(40), State VARCHAR(40), Country VARCHAR(40), PostalCode VARCHAR(10), Phone VARCHAR(24), Fax VARCHAR(24), Email VARCHAR(60), SupportRapid INT );   


CREATE TABLE customers (customerID int, customerName varchar(50), customerAddress varchar(255));  
INSERT INTO customers (customerID, customerName, customerAddress) VALUES (1, "Jack", "115 Old street Belfast");  
INSERT INTO customers(customerID, customerName, customerAddress) VALUES (2, "James", "24 Carlson Rd London") ;

## Arithmetic operators

SELECT salary + allowance FROM employee;  


SELECT *  
FROM employee  
WHERE salary - tax = 50000; 

## Comparison operators

SELECT *  
FROM employee  
WHERE tax >= 1000;  

## Ordering

SELECT *  
FROM Employee  
ORDER BY <order by column name>; 

SELECT *  
FROM invoices  
ORDER BY BillingCity ASC, InvoiceDate DESC;  

## Where

SELECT column1, column2, columnN  
FROM table_name   
WHERE [condition1] AND [condition2]...AND [conditionN]; 

SELECT *   
FROM invoices    
WHERE Total > 2 AND (BillingCountry = 'USA' OR BillingCountry = 'France'); 

## Distinct

SELECT DISTINCT BillingCountry  
FROM invoices  
ORDER BY BillingCountry; 

SELECT COUNT(DISTINCT country)  
FROM customers;

## Building a Schema

CREATE TABLE tbl(  
    table_id INT,  
    location VARCHAR(255),  
    PRIMARY KEY (table_id)  
); 

CREATE TABLE waiter(  
    waiter_id INT,  
    name VARCHAR(150),  
    contact_no VARCHAR(10),  
    shift VARCHAR(10),  
    PRIMARY KEY (waiter_id)  
); 

CREATE TABLE table_order( 
    order_id INT,  
    date_time DATETIME,  
    table_id INT,  
    waiter_id INT,  
    PRIMARY KEY (order_id),  
    FOREIGN KEY (table_id) REFERENCES tbl(table_id),  
    FOREIGN KEY (waiter_id) REFERENCES waiter(waiter_id)  
); 

## Filtering

SELECT * FROM employees WHERE AnnualSalary < 50000 AND Department IN('Marketing', 'Finance', 'Legal');  
SELECT * FROM employees WHERE AnnualSalary BETWEEN 10000 AND 50000;  
SELECT * FROM employees WHERE EmployeeName LIKE 'S___%';

## JOIN

SELECT Customers.FullName, Bookings.BookingID   
FROM Customers INNER JOIN Bookings   
ON Customers.CustomerID = Bookings.CustomerID; 

SELECT Customers.FullName, Bookings.BookingID  
FROM Customers LEFT JOIN Bookings  
ON Customers.CustomerID =  Bookings.CustomerID; 

## Grouping

SELECT OrderDate,COUNT(OrderID) FROM Orders GROUP BY OrderDate;  
SELECT Department, SUM(OrderQty) FROM Orders GROUP BY Department;  
SELECT OrderDate,COUNT(OrderID) FROM Orders GROUP BY OrderDate HAVING OrderDate BETWEEN '2022-06-01' AND '2022-06-30';

## REPLACE
insert and update if pri key already present (Mix of insert into and update)

REPLACE INTO table_name (column1name, column2name, ...)  VALUES (value1, value2, ...);

## Constraints

CREATE TABLE Clients (ClientID INT PRIMARY KEY, FullName VARCHAR(100) NOT NULL, PhoneNumber INT NOT NULL UNIQUE);  
CREATE TABLE Items (ItemID INT PRIMARY KEY, ItemName VARCHAR(100) NOT NULL, Price DECIMAL(5,2) NOT NULL); 

CREATE TABLE Orders (  
OrderID INT PRIMARY KEY,    
ItemID INT NOT NULL,    
ClientID INT NOT NULL,   
Quantity INT NOT NULL CHECK (Quantity < 4),  
Cost DECIMAL(6,2) NOT NULL,  
FOREIGN KEY (ClientID) REFERENCES Clients (ClientID),  
FOREIGN KEY (ItemID) REFERENCES Items (ItemID)  
);

CREATE TABLE ContractInfo (ContractID INT NOT NULL PRIMARY KEY, StaffID INT NOT NULL, Salary Decimal(7, 2) NOT NULL, Location VARCHAR(50) NOT NULL DEFAULT "Texas", StaffType VARCHAR(20) NOT NULL CHECK (StaffType = "Junior" OR StaffType = "Senior"));  
CREATE TABLE ContractInfo (ContractID INT NOT NULL PRIMARY KEY, StaffID INT NOT NULL, Salary Decimal(7, 2) NOT NULL, Location VARCHAR(50) NOT NULL, StaffType VARCHAR(20) NOT NULL CHECK (StaffType = "Junior" OR StaffType = "Senior"), FOREIGN KEY (StaffID) REFERENCES Staff(StaffID));

## Changing table strucutre

ALTER TABLE Staff MODIFY StaffID INT PRIMARY KEY, MODIFY FullName VARCHAR(100) NOT NULL, MODIFY PhoneNumber INT NOT NULL;  
ALTER TABLE Staff ADD COLUMN Role VARCHAR(50) NOT NULL;  
ALTER TABLE Staff DROP COLUMN PhoneNumber;  
ALTER TABLE OrderStatus CHANGE Order_status DeliveryStatus VARCHAR(15);  
ALTER TABLE OrderStatus RENAME OrderDeliveryStatus;

## SUBQUERIES

SELECT * FROM MenuItems WHERE Price = (SELECT Price FROM Menus, MenuItems WHERE Menus.ItemID = MenuItems.ItemID AND MenuItems.Type = 'Starters' AND Cuisine = 'Italian');  
SELECT * FROM MenuItems  
WHERE NOT EXISTS (SELECT * FROM TableOrders, Menus WHERE TableOrders.MenuID = Menus.MenuID AND Menus.ItemID = MenuItems.ItemID);  

SELECT * FROM MenuItems WHERE Price > ALL (SELECT Price FROM MenuItems WHERE Type IN ('Starters', 'Desserts'));  

INSERT INTO LowCostMenuItems  
SELECT ItemID,Name,Price  
FROM MenuItems  
WHERE Price =ANY(SELECT MIN(Price) FROM MenuItems GROUP BY Type);

DELETE FROM LowCostMenuItems  
WHERE Price > ALL(SELECT MIN(Price) as p  
FROM MenuItems  
GROUP BY Type  
HAVING p BETWEEN 5 AND 10);

## View
In SQL, a VIEW acts as a virtual table that utilizes data stored in existing tables in the database. The virtual table does not store any data itself. Instead, it acts as an interface that provides access to existing data.

CREATE VIEW OrdersView AS SELECT OrderID, Quantity, Cost FROM Orders;  
UPDATE OrdersView SET Cost = 200 WHERE OrderID = 2;  
RENAME TABLE OrdersView TO ClientsOrdersView;  
DROP VIEW ClientsOrdersView; 

## FUNCTIONS

SELECT CONCAT(LCASE(Name),'-',Quantity,'-', UCASE(OrderStatus))  
FROM item,mg_orders  
WHERE item.ItemID = mg_orders.ItemID;  

SELECT DATE_FORMAT(DeliveryDate,'%W') FROM mg_orders;  
SELECT OrderID, ROUND((Cost * 5 / 100),2) AS HandlingCost FROM mg_orders;   
SELECT DATE_FORMAT(DeliveryDate,'%W') FROM mg_orders WHERE !ISNULL(DeliveryDate) 
SELECT ADDDATE(OrderDate,30) AS ExpectedDelDate FROM mg_orders;  
SELECT CEIL(15.50);  

## PROCEDURES

CREATE PROCEDURE GetItalianCustomers() SELECT * FROM Customers WHERE Country = “Italy”;  
CALL GetItalianCustomers();  
CREATE PROCEDURE GetProductsBasedOnPrice (inputPrice INT)  
SELECT * FROM Products WHERE Price <= inputPrice;

## FUNCTIONS
A function returns a single value, whereas a procedure may return a single value, multiple values or no value. Typically, functions encapsulate common formulas or generic business rules that are reusable among SQL statements and stored procedures. Procedures, on the other hand, are used mainly to process, manipulate and modify data in the database.

DELIMITER //  
CREATE FUNCTION GetCostAverage() RETURNS DECIMAL(5,2) DETERMINISTIC  
BEGIN  
RETURN (SELECT AVG(Cost) FROM Orders);  
END //  
DELIMITER;  

CREATE FUNCTION FindCost(order_id INT)  
RETURNS DECIMAL (5,2) DETERMINISTIC  
RETURN (SELECT Cost FROM Orders WHERE OrderID = order_id);

## TRIGERS

CREATE TRIGGER trigger_name  
{BEFORE | AFTER} {INSERT | UPDATE| DELETE}  
ON table_name FOR EACH ROW  
trigger_body;

CREATE TRIGGER OrderQtyCheck  
  BEFORE INSERT ON Orders  
  FOR EACH ROW  
BEGIN  
  IF NEW.Quantity < 0 THEN  
    SET NEW.Quantity = 0;  
  END IF;  
END;

## OPTIMIZATIONS

- Avoiding the use of unnecessary columns in the SELECT clause.  
- Avoiding the use of functions in predicates (WHERE clause conditions).  
- Avoiding the use of leading wildcards in predicates, particularly with the LIKE operator.  
- Using INNER JOIN instead of OUTER JOIN.   
- Using DISTINCT and UNION sparingly in SELECT queries

START TRANSACTION;  
SQL statements  
ROLLBACK; 

CTE  
WITH  
  cte1 AS (query1),  
  cte2 AS (query2)  
SELECT cte1  UNION cte2;

prepared statement  
PREPARE InsertProductData ‘INSERT INTO Products VALUES(?, ?)’;  

JSON  
SELECT Activity.Properties ->>'$.ProductID'  
AS ProductID, Products.ProductName, Products.BuyPrice, Products.SellPrice  
FROM Products INNER JOIN Activity  
ON Products.ProductID = Activity.Properties ->>'$.ProductID'  
WHERE Activity.Properties ->>'$.Order' = "True";  