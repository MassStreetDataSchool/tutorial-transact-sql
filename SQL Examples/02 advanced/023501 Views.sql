USE AdventureWorks2016
GO

DROP VIEW IF EXISTS SalesReport

GO

CREATE VIEW SalesReport AS

SELECT
CONCAT(p.FirstName, ' ',p.LastName) AS SalesPerson,
DATENAME(MONTH,soh.OrderDate) AS MonthOfSale,
DATEPART(YEAR,soh.OrderDate) AS YearOfSale,
SUM(sod.LineTotal) AS TotalSales
FROM Person.Person p
JOIN Sales.SalesPerson sp
ON p.BusinessEntityID = sp.BusinessEntityID
JOIN Sales.SalesOrderHeader soh
ON sp.BusinessEntityID = soh.SalesPersonID
JOIN Sales.SalesOrderDetail sod
ON soh.SalesOrderID = sod.SalesOrderDetailID
GROUP BY p.LastName, p.FirstName, DATENAME(month,soh.OrderDate), DATEPART(YEAR,soh.OrderDate)