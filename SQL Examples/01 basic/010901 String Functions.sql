USE AdventureWorks2016

SELECT
FirstName,
MiddleName,
LastName,
CONCAT(FirstName,MiddleName,LastName) AS SmooshedTogether
FROM Person.Person

SELECT 
Description,
LEN(Description) AS CountOfCharactersInDescription
FROM Production.ProductDescription

SELECT 
Description,
LEFT(Description,20) AS Left20Chars
FROM Production.ProductDescription

SELECT 
Description,
RIGHT(Description,20) AS Right20Chars
FROM Production.ProductDescription

SELECT 
Description,
LTRIM(Description) AS LeadingSpaceRemoved
FROM Production.ProductDescription

SELECT 
Description,
RTRIM(Description) AS TrailingSpaceRemoved
FROM Production.ProductDescription

SELECT 
Description,
REPLACE(Description,'large', 'small') AS DescriptionChanged
FROM Production.ProductDescription
WHERE ProductDescriptionID = 4

SELECT 
Description,
SUBSTRING(Description, 10, 15) AS RandomSubstringSelection
FROM Production.ProductDescription