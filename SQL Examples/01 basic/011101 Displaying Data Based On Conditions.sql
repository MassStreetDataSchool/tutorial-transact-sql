USE AdventureWorks2016

SELECT 
ProductNumber,
Name AS ProductName,
Color,
CASE
WHEN Color IS NOT NULL THEN Color
ELSE 'Color Is Not Avalable'
END AS ProductColor
FROM Production.Product

SELECT 
SalesOrderDetailID,
OrderQty,
LineTotal,
CASE
WHEN LineTotal BETWEEN 0 AND 1000 THEN 'These guys are cheap.'
WHEN LineTotal BETWEEN 1000 AND 20000 THEN 'These guys are alright.'
WHEN LineTotal > 20000 THEN 'These guys are big spenders'
ELSE 'Who the heck are these guys'
END AS CommentsFromTheCMO
FROM Sales.SalesOrderDetail