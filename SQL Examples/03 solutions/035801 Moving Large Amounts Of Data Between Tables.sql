USE demo

DECLARE @Year INT
DECLARE @Month INT
DECLARE @i INT = 1

DROP TABLE IF EXISTS FlightsStaging
DROP TABLE IF EXISTS SelectFlightData

CREATE TABLE FlightsStaging(
year NVARCHAR(255) NULL,
month NVARCHAR(255) NULL,
day NVARCHAR(255) NULL,
dep_time NVARCHAR(255) NULL,
sched_dep_time NVARCHAR(255) NULL,
dep_delay NVARCHAR(255) NULL,
arr_time NVARCHAR(255) NULL,
sched_arr_time NVARCHAR(255) NULL,
arr_delay NVARCHAR(255) NULL,
carrier NVARCHAR(255) NULL,
flight NVARCHAR(255) NULL,
tailnum NVARCHAR(255) NULL,
origin NVARCHAR(255) NULL,
dest NVARCHAR(255) NULL,
air_time NVARCHAR(255) NULL,
distance NVARCHAR(255) NULL,
hour NVARCHAR(255) NULL,
minute NVARCHAR(255) NULL,
time_hour NVARCHAR(255) NULL,
)

CREATE TABLE SelectFlightData(
carrier NVARCHAR(255) NULL,
flight NVARCHAR(255) NULL,
tailnum NVARCHAR(255) NULL,
BatchLoadNumber TINYINT NULL,
)

BULK INSERT FlightsStaging
FROM 'E:\flights.csv'
WITH (
FIELDTERMINATOR = ',',
ROWTERMINATOR = '0x0a',
FIRSTROW = 2
);

DECLARE BatchingCursor CURSOR FOR
SELECT DISTINCT year, month
FROM FlightsStaging

OPEN BatchingCursor;
FETCH NEXT FROM BatchingCursor INTO @Year, @Month;
WHILE @@FETCH_STATUS = 0
BEGIN

BEGIN TRANSACTION
INSERT INTO SelectFlightData(carrier, flight, tailnum, BatchLoadNumber)
SELECT carrier, flight, tailnum, @i
FROM FlightsStaging
WHERE year = @Year AND month = @Month     
COMMIT TRANSACTION

SET @i = @i + 1

FETCH NEXT FROM BatchingCursor INTO @Year, @Month;
END;
CLOSE BatchingCursor;
DEALLOCATE BatchingCursor;
GO

SELECT *
FROM SelectFlightData

SELECT BatchLoadNumber, COUNT(BatchLoadNumber) AS NumberOfRecordsLoadedInBatch
FROM SelectFlightData
GROUP BY BatchLoadNumber
ORDER BY BatchLoadNumber

DROP TABLE FlightsStaging
DROP TABLE SelectFlightData