USE AdventureWorks2016

--this is valid SQL
SELECT SUM(LineTotal)
FROM Sales.SalesOrderDetail
GROUP BY ProductID

--this is a syntax violation
SELECT UnitPrice, SUM(LineTotal)
FROM Sales.SalesOrderDetail
GROUP BY ProductID

SELECT ProductID, SUM(LineTotal) AS SumOfOrders
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(LineTotal) > 100000