USE AdventureWorks2016

SELECT *
FROM Sales.SalesOrderDetail
WHERE ProductID IN (SELECT ProductID FROM Production.Product WHERE MakeFlag = 1)