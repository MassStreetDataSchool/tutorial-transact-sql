USE AdventureWorks2016


SELECT 
p.FirstName,
p.LastName,
e.JobTitle,
e.HireDate
FROM Person.Person p
LEFT OUTER JOIN HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID