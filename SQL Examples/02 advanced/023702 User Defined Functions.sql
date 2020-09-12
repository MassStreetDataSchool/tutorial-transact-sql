USE demo

DECLARE @UnixTimeStamp BIGINT = 1599624698

SELECT dbo.udf_ConvertUnixTimeStamp(@UnixTimeStamp) AS TheDate