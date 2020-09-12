USE demo

INSERT INTO DimProducts(ProductName)
SELECT 'Microsoft Office 365'
UNION ALL
SELECT 'Microsoft Access 2013'
UNION ALL
SELECT 'Microsoft Access 2013'
UNION ALL
SELECT 'Microsoft SQL Server 2012'
UNION ALL
SELECT 'Microsoft SQL Server 2012'
UNION ALL
SELECT 'Microsoft SQL Server 2012'
UNION ALL
SELECT 'Microsoft Visual Studio 2013'
UNION ALL
SELECT 'Microsoft Visual Studio 2013'

--let's check our work
SELECT * FROM DimProducts

--Now let's load some sales
DECLARE @TempSales TABLE (Price MONEY, ItemCount INT)
INSERT INTO @TempSales
SELECT 300.00, 5
UNION
SELECT 520.00, 10

--Each record in @TempSales doesn't represent a transaction.
--We just want to have more than one invoice for a particular
--product.
INSERT INTO FactProductSales(ProductID, Price, ItemCount)
SELECT p.ProductID, ts.Price, ts.ItemCount
FROM DimProducts p
CROSS JOIN @TempSales ts

--let's check our work
SELECT * FROM FactProductSales ORDER BY ProductID

--And with the join
SELECT p.ProductName, ps.ProductID, ps.InvoiceID AS InvoiceNumber, ps.Price, ps.ItemCount, ps.InvoiceTotal
FROM DimProducts p
JOIN FactProductSales ps
ON p.ProductID = ps.ProductID
ORDER BY p.ProductName