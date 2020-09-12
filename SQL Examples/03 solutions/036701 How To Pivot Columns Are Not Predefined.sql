USE AdventureWorks2016

DECLARE @columns AS NVARCHAR(MAX)
DECLARE @sql  AS NVARCHAR(MAX)

DROP TABLE IF EXISTS #SalesReport

--We turn month of sale into an string value so we can add a leading zero later.
CREATE TABLE #SalesReport (SalesPerson NVARCHAR(50), MonthOfSale NVARCHAR(2), TotalSales MONEY)
;


INSERT INTO #SalesReport (SalesPerson, MonthOfSale, TotalSales)
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
;

--Add the leading zero so the output goes from Jan to December.
UPDATE #SalesReport
SET MonthOfSale =
CASE
WHEN LEN(MonthOfSale) = 1 THEN '0'+ MonthOfSale
ELSE MonthOfSale
END


SELECT @columns = STUFF(
(
SELECT DISTINCT ',' + QUOTENAME(MonthOfSale) 
FROM #SalesReport
FOR XML PATH(''), TYPE
).value('.', 'NVARCHAR(MAX)'),1,1,''
)

SET @sql = 'SELECT SalesPerson, ' + @columns + ' FROM
(
SELECT SalesPerson, MonthOfSale, TotalSales
FROM #SalesReport
) x
PIVOT 
(
MIN(TotalSales)
FOR MonthOfSale IN (' + @columns + ')
) y '

execute(@sql)

DROP TABLE #SalesReport