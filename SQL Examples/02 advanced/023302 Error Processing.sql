USE demo

DECLARE @UserInput INT

BEGIN TRY
SET @UserInput = 'Wakefield'
END TRY
BEGIN CATCH
PRINT 'Please input an integer value.'
END CATCH