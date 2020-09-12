USE demo

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
--DROP TABLE FactProductSales
--DROP TABLE DimProducts