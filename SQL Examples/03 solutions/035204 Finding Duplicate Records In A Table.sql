USE demo

--Create our product table
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.DimProducts') AND type in (N'U'))
ALTER TABLE dbo.DimProducts DROP CONSTRAINT IF EXISTS FK_Products_Products
GO

DROP TABLE IF EXISTS dbo.DimProducts
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.DimProducts') AND type in (N'U'))
BEGIN
CREATE TABLE dbo.DimProducts(
ProductID bigint IDENTITY(1,1) NOT NULL,
ProductName nvarchar(50) NULL,
 CONSTRAINT PK_Products PRIMARY KEY CLUSTERED 
(
	ProductID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'dbo.FK_Products_Products') AND parent_object_id = OBJECT_ID(N'dbo.DimProducts'))
ALTER TABLE dbo.DimProducts  WITH CHECK ADD  CONSTRAINT FK_Products_Products FOREIGN KEY(ProductID)
REFERENCES dbo.DimProducts (ProductID)
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'dbo.FK_Products_Products') AND parent_object_id = OBJECT_ID(N'dbo.DimProducts'))
ALTER TABLE dbo.DimProducts CHECK CONSTRAINT FK_Products_Products
GO


--Create our product sales table
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.FactProductSales') AND type in (N'U'))
ALTER TABLE dbo.FactProductSales DROP CONSTRAINT IF EXISTS FK_ProductSales_Products
GO

DROP TABLE IF EXISTS dbo.FactProductSales
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.FactProductSales') AND type in (N'U'))
BEGIN
CREATE TABLE dbo.FactProductSales(
InvoiceID bigint IDENTITY(1,1) NOT NULL,
ProductID bigint NOT NULL,
Price money NOT NULL,
ItemCount int NOT NULL,
InvoiceTotal  AS (Price*ItemCount),
 CONSTRAINT PK_ProductSales PRIMARY KEY CLUSTERED 
(
	InvoiceID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'dbo.FK_ProductSales_Products') AND parent_object_id = OBJECT_ID(N'dbo.FactProductSales'))
ALTER TABLE dbo.FactProductSales  WITH CHECK ADD  CONSTRAINT FK_ProductSales_Products FOREIGN KEY(ProductID)
REFERENCES dbo.DimProducts (ProductID)
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'dbo.FK_ProductSales_Products') AND parent_object_id = OBJECT_ID(N'dbo.FactProductSales'))
ALTER TABLE dbo.FactProductSales CHECK CONSTRAINT FK_ProductSales_Products
GO

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


--Looks peachy but we know some of those product IDs are bogus.
--Let's fix it.

--First we need keep track of the dups
--If you have a large amount of dups, use a
--temp table instead.
DECLARE @DuplicateProductIDs TABLE(RowNumber INT, ProductID BIGINT, ProductName NVARCHAR(50))

INSERT INTO @DuplicateProductIDs(RowNumber, ProductID, ProductName)
SELECT ROW_NUMBER() OVER (PARTITION BY ProductName ORDER BY ProductName) AS RowNumber, ProductID, ProductName
FROM DimProducts

SELECT * FROM @DuplicateProductIDs

--Let's fix our child table so the records point to the right product
--First we need to transform the Dup ID info so we know which dup ID
--belongs to the original ID
DECLARE @RealProductIDsWithDupes TABLE(OriginalProductID BIGINT, DuplicateProductID BIGINT, ProductName NVARCHAR(50))

;
WITH OriginalProductIDs(OriginalProductID, ProductName)
AS(
SELECT ProductID, ProductName
FROM @DuplicateProductIDs
WHERE RowNumber = 1
),
DuplicateProductIDs(DuplicateProductID, ProductName)
AS(
SELECT ProductID, ProductName
FROM @DuplicateProductIDs
WHERE RowNumber <> 1
)
INSERT INTO @RealProductIDsWithDupes(OriginalProductID, DuplicateProductID, ProductName)
SELECT opid.OriginalProductID, dpid.DuplicateProductID, opid.ProductName
FROM OriginalProductIDs opid
JOIN DuplicateProductIDs dpid
ON opid.ProductName = dpid.ProductName

--check
SELECT * FROM @RealProductIDsWithDupes

--Now let's fix our child table

--Before
SELECT * FROM FactProductSales ORDER BY ProductID

UPDATE ps
SET ps.ProductID = rpids.OriginalProductID
FROM FactProductSales ps
JOIN @RealProductIDsWithDupes rpids
ON rpids.DuplicateProductID = ps.ProductID

--After
--Number of rows should not have changed but the
--number of distinct product IDs should be reduced.
SELECT * FROM FactProductSales ORDER BY ProductID

--Now that we won't violate any FK restraints,
--we can safely blow away dups in the parent

DELETE 
FROM DimProducts
WHERE ProductID IN(
SELECT ProductID
FROM @DuplicateProductIDs
WHERE RowNumber <> 1
)

--Check
SELECT * FROM DimProducts

--Final result
SELECT ps.InvoiceID AS InvoiceNumber, ps.ProductID, p.ProductName,  ps.Price, ps.ItemCount, ps.InvoiceTotal
FROM DimProducts p
JOIN FactProductSales ps
ON p.ProductID = ps.ProductID
ORDER BY p.ProductID



--Clean up your mess
DROP TABLE FactProductSales
DROP TABLE DimProducts