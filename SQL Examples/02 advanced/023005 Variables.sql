USE AdventureWorks2016

DECLARE @FirstName NVARCHAR(20) = (SELECT FirstName FROM Person.Person WHERE BusinessEntityID = 1)

DECLARE @LastName NVARCHAR(20) 

SELECT @LastName = LastName
FROM Person.Person 
WHERE BusinessEntityID = 1

SELECT @FirstName, @LastName