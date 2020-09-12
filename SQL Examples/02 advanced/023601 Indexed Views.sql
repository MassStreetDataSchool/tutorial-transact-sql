USE AdventureWorks2016


DROP VIEW IF EXISTS Person

GO

CREATE VIEW Person
 
WITH SCHEMABINDING  
AS  
SELECT
BusinessEntityID,
FirstName,
LastName
FROM Person.Person
GO  
--Create an index on the view.  
CREATE UNIQUE CLUSTERED INDEX CIDX_PERSON_BUSINESSENTITYID ON Person(BusinessEntityID);  
GO 