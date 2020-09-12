USE AdventureWorks2016

SELECT *
FROM Production.Product
WHERE 1 = 1

SELECT *
FROM Production.Product
WHERE 1 = 1
AND SafetyStockLevel = 1000

SELECT *
FROM Production.Product
WHERE 1 = 1
AND SafetyStockLevel != 1000

SELECT *
FROM Production.Product
WHERE 1 = 1
AND ReorderPoint >= 600

SELECT *
FROM Production.Product
WHERE 1 = 1
AND SafetyStockLevel != 1000

SELECT *
FROM Production.Product
WHERE 1 = 1
AND ListPrice BETWEEN 50 AND 100

SELECT *
FROM Production.Product
WHERE 1 = 1
AND Size IS NOT NULL
AND MakeFlag = 1

SELECT *
FROM Production.Product
WHERE 1 = 1
AND Size IS NOT NULL
OR Color = 'Black'

SELECT *
FROM Production.Product
WHERE 1 = 1
AND (ReorderPoint > 350 AND ListPrice <> 0)
OR (Color = 'Black' AND ListPrice = 0)