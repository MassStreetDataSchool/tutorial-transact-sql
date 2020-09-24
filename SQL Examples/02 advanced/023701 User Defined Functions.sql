USE demo

DROP FUNCTION IF EXISTS dbo.udf_ConvertUnixTimeStamp

GO

CREATE FUNCTION dbo.udf_ConvertUnixTimeStamp (@UnixTimeStamp BIGINT)
RETURNS DATETIME
AS
BEGIN
DECLARE @LocalTimeOffset BIGINT = DATEDIFF(SECOND,GETDATE(),GETUTCDATE())
DECLARE @AdjustedLocalDatetime BIGINT;
SET @AdjustedLocalDatetime = @UnixTimeStamp - @LocalTimeOffset
RETURN (SELECT DATEADD(SECOND, @AdjustedLocalDatetime, CAST('1970-01-01 00:00:00' AS DATETIME)))
END;
GO