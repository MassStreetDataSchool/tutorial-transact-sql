USE AdventureWorks2016

;
WITH PersonWithNoMiddleName(BusinessEntityID, FirstName, LastName)
AS(
SELECT BusinessEntityID, FirstName, LastName
FROM Person.Person
WHERE MiddleName IS NULL
)
SELECT 
pwnmn.FirstName,
pwnmn.LastName,
e.EmailAddress
FROM Person.EmailAddress e
JOIN PersonWithNoMiddleName pwnmn
ON pwnmn.BusinessEntityID = e.BusinessEntityID