USE AdventureWorks2016

DECLARE @SQL NVARCHAR(255)
DECLARE @TableName NVARCHAR(255)

SET @TableName = 'Sales.SalesOrderDetail'

SET @SQL = 'SELECT * FROM ' + @TableName

EXEC sp_executesql @SQL