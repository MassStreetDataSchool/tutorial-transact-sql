USE AdventureWorks2016

DECLARE @Title NVARCHAR(5) = 'Mr.'
DECLARE @BusinessEntityID TINYINT = 1

SELECT @Title AS Title, FirstName, LastName 
FROM Person.Person 
WHERE BusinessEntityID = @BusinessEntityID