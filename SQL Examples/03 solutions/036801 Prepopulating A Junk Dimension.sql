USE demo

--create necessary tables
DECLARE @ProductInformation AS TABLE (Color NVARCHAR(20), Size NVARCHAR(1), isActiveProduct BIT)
DECLARE @Color AS TABLE(Color NVARCHAR(20))
DECLARE @Size AS TABLE(Size NVARCHAR(1))
DECLARE @isActiveProduct AS TABLE(isActiveProduct BIT)

--populate component tables
INSERT INTO @Color(Color)
SELECT 'Red'
UNION
SELECT 'Blue'
UNION
SELECT 'Brown'
UNION
SELECT 'Green'
UNION
SELECT 'Yellow'

INSERT INTO @Size(Size)
SELECT 'S'
UNION
SELECT 'M'
UNION
SELECT 'L'

INSERT INTO @isActiveProduct(isActiveProduct)
SELECT '1'
UNION
SELECT '0'

--Prepopulate table
INSERT INTO @ProductInformation(Color, Size, isActiveProduct)
SELECT Color, Size, isActiveProduct 
FROM @Color
CROSS JOIN @Size
CROSS JOIN @isActiveProduct

--gloat over my math superiority
SELECT COUNT(*) AS TotalRecords
FROM @ProductInformation

--see the results
SELECT *
FROM @ProductInformation