USE AdventureWorks2016


--Here is how we find Barb using her national ID number.
SELECT 
p.FirstName,
p.LastName,
e.NationalIDNumber,
e.Gender
FROM Person.Person p
JOIN HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID
WHERE e.NationalIDNumber = '969985265'

--now to update Barb's last name of Decker to her new last name Mudd.
UPDATE p
SET 
p.LastName = 'Mudd',
p.ModifiedDate = CURRENT_TIMESTAMP --don't get in a hurry and forget to populate audit columns
FROM Person.Person p
JOIN HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID
WHERE e.NationalIDNumber = '969985265'

--Let's confirm the change was made.
SELECT 
p.FirstName,
p.LastName,
e.NationalIDNumber,
e.Gender
FROM Person.Person p
JOIN HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID
WHERE e.NationalIDNumber = '969985265'