USE AdventureWorks2016

SELECT MAX(LineTotal) AS BiggestLineTotal
FROM Sales.SalesOrderDetail
 
SELECT MIN(LineTotal) AS SmallestLineTotal
FROM Sales.SalesOrderDetail

SELECT AVG(LineTotal) AS AverageLineTotal
FROM Sales.SalesOrderDetail

SELECT COUNT(SalesOrderDetailID) AS TotalRecordsInTable
FROM Sales.SalesOrderDetail

SELECT SUM(LineTotal) AS TotalOfTheOrdersInTheTable
FROM Sales.SalesOrderDetail