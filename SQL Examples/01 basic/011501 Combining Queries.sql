USE AdventureWorks2016

SELECT RevisionNumber
FROM Sales.SalesOrderHeader
UNION
SELECT SalesOrderID AS RevisionNumber
FROM Sales.SalesOrderHeader


SELECT RevisionNumber
FROM Sales.SalesOrderHeader
UNION ALL
SELECT SalesOrderID AS RevisionNumber
FROM Sales.SalesOrderHeader