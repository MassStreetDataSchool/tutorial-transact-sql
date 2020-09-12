USE demo

DECLARE @Year INT
DECLARE @Month INT

DECLARE BatchingCursor CURSOR FOR
SELECT DISTINCT YEAR([SomeDateField]),MONTH([SomeDateField])
FROM [Sometable];


OPEN BatchingCursor;
FETCH NEXT FROM BatchingCursor INTO @Year, @Month;
WHILE @@FETCH_STATUS = 0
BEGIN

BEGIN TRANSACTION
--All logic goes in here
--Any select statements from [Sometable] need to be suffixed with:
--WHERE Year([SomeDateField])=@Year AND Month([SomeDateField])=@Month   
COMMIT TRANSACTION

FETCH NEXT FROM BatchingCursor INTO @Year, @Month;
END;
CLOSE BatchingCursor;
DEALLOCATE BatchingCursor;
GO