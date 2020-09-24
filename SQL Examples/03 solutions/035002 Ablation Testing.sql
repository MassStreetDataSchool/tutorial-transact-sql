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
WHERE 1 = 1
AND sp.Bonus BETWEEN 3000.00 AND 6000.00
--AND sp.SalesYTD >= 2000000.00
--AND sod.UnitPrice < 2000
AND (YEAR(soh.OrderDate) BETWEEN 2014 AND 2013 OR YEAR(soh.OrderDate) = 2011)
GROUP BY p.LastName, p.FirstName, DATEPART(month,soh.OrderDate)
ORDER BY p.LastName, p.FirstName, DATEPART(month,soh.OrderDate)