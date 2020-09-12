USE demo

DECLARE @i TINYINT = 1

WHILE @i < 10 BEGIN
PRINT 'The variable''s value is ' + CAST(@i AS NVARCHAR(1)) + '.'
SET @i = @i + 1
END