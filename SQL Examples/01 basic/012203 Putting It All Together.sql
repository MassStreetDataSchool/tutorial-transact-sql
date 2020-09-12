USE AdventureWorks2016

SELECT
CONCAT(p.FirstName, ' ',p.LastName) AS SalesPerson,
DATEPART(month,soh.OrderDate) AS MonthOfSale,
SUM(sod.LineTotal) AS TotalSales
FROM Person.Person p
JOIN Sales.SalesPerson sp
ON p.BusinessEntityID = sp.BusinessEntityID
JOIN Sales.SalesOrderHeader soh
ON sp.BusinessEntityID = soh.SalesPersonID
JOIN Sales.SalesOrderDetail sod
ON soh.SalesOrderID = sod.SalesOrderDetailID
GROUP BY p.LastName, p.FirstName, DATEPART(month,soh.OrderDate)
ORDER BY p.LastName, p.FirstName, DATEPART(month,soh.OrderDate)