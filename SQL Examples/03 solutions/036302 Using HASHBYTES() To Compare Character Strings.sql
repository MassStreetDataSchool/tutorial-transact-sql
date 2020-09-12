Use AdventureWorks2016

DECLARE @Statement1 NVARCHAR(255)
DECLARE @Statement2 NVARCHAR(255)

SET @Statement1 = 'WalMart'
SET @Statement2 = 'walmart'


PRINT HASHBYTES('MD5', @Statement1)
PRINT HASHBYTES('MD5', @Statement2)