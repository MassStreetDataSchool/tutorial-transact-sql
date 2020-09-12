USE AdventureWorks2016

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


SELECT *
FROM [Sales].[SalesOrderHeader] soh
JOIN [Sales].[SalesOrderDetail] sod
ON soh.SalesOrderID = sod.SalesOrderID

SET TRANSACTION ISOLATION LEVEL READ COMMITTED