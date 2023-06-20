SELECT c.CustomerID, c.CustomerName AS FullName, 
	   o.OrderID, o.TotalCost AS Cost,
       m.Cuisine AS MenuName,
       i.ItemName AS CourseName
FROM customers c
INNER JOIN orders o
	ON c.CustomerID = o.CustomerID
INNER JOIN menus m
	ON m.MenuID = o.MenuID
INNER JOIN menuitems i
	ON i.ItemID = m.ItemID
WHERE o.TotalCost > 150
ORDER BY o.TotalCost ASC
