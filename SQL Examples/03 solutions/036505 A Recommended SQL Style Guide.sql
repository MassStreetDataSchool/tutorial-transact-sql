USE AdventureWorks2016

DROP PROCEDURE IF EXISTS dbo.usp_NoCountExample
GO

CREATE PROCEDURE dbo.usp_NoCountExample

AS
BEGIN

SET NOCOUNT ON;

SELECT *
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod
ON soh.SalesOrderID = sod.SalesOrderID
WHERE 1 = 1

SET NOCOUNT OFF;

END;
GO