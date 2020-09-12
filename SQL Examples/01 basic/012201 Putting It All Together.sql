USE AdventureWorks2016

SELECT
p.FirstName,
p.LastName,
soh.OrderDate,
sod.LineTotal
FROM Person.Person p
JOIN Sales.SalesPerson sp
ON p.BusinessEntityID = sp.BusinessEntityID
JOIN Sales.SalesOrderHeader soh
ON sp.BusinessEntityID = soh.SalesPersonID
JOIN Sales.SalesOrderDetail sod
ON soh.SalesOrderID = sod.SalesOrderDetailID