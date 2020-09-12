USE demo

DROP TABLE IF EXISTS Person
DROP TABLE IF EXISTS PersonStageTable

CREATE TABLE Person(
PersonID BIGINT NOT NULL,
FirstName NVARCHAR(50) NULL,
LastName NVARCHAR(50) NULL,
SourceSystemKey NVARCHAR(50) NULL,
)

CREATE TABLE PersonStageTable(
PersonID BIGINT NOT NULL,
FirstName NVARCHAR(50) NULL,
LastName NVARCHAR(50) NULL,
SourceSystemKey NVARCHAR(50) NULL,
)

INSERT INTO Person(PersonID, FirstName, LastName, SourceSystemKey)
SELECT 1, 'Bob', 'Wakefield',1

INSERT INTO PersonStageTable(PersonID, FirstName, LastName, SourceSystemKey)
SELECT 1,'Bob','Johnson',1
UNION 
SELECT 2,'Sally','Ride',2

SELECT * FROM Person

SELECT * FROM PersonStageTable