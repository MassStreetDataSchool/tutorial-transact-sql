USE AdventureWorks2016

;
WITH PersonWithNoMiddleName(BusinessEntityID, FirstName, LastName)
AS(
SELECT BusinessEntityID, FirstName, LastName
FROM Person.Person
WHERE MiddleName IS NULL
)
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
JOIN PersonWithNoMiddleName pwnmn
ON pwnmn.BusinessEntityID = p.BusinessEntityID
WHERE 1 = 1
AND sod.CarrierTrackingNumber IN (SELECT CarrierTrackingNumber FROM Sales.SalesOrderDetail WHERE CarrierTrackingNumber IS NOT NULL)
GROUP BY p.LastName, p.FirstName, DATEPART(month,soh.OrderDate)
ORDER BY p.LastName, p.FirstName, DATEPART(month,soh.OrderDate)