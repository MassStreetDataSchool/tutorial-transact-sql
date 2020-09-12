USE AdventureWorks2016

SELECT 
pwnmn.FirstName,
pwnmn.LastName,
e.EmailAddress
FROM Person.EmailAddress e
JOIN(
SELECT BusinessEntityID, FirstName, LastName
FROM Person.Person
WHERE MiddleName IS NULL
) AS pwnmn
ON pwnmn.BusinessEntityID = e.BusinessEntityID