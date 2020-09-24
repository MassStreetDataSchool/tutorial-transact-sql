USE demo

DECLARE @Statement1 NVARCHAR(255)
DECLARE @Statement2 NVARCHAR(255)

SET @Statement1 = 'Army And Navy Play For Second '
SET @Statement2 = 'Rock Chalk Jayhawk'

PRINT LEN(@Statement1)
PRINT LEN(@Statement2)

PRINT HASHBYTES('MD5', @Statement1)
PRINT HASHBYTES('MD5', @Statement2)

PRINT LEN(HASHBYTES('MD5', @Statement1))
PRINT LEN(HASHBYTES('MD5', @Statement2))