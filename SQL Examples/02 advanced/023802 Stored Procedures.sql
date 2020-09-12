USE demo

GO

DROP PROCEDURE IF EXISTS usp_LoadPersonTable

GO

CREATE PROCEDURE usp_LoadPersonTable AS

BEGIN

MERGE Person AS target
USING (
SELECT
PersonID,
FirstName,
LastName,
SourceSystemKey
FROM PersonStageTable
) AS source
ON (target.SourceSystemKey = source.SourceSystemKey)

WHEN NOT MATCHED THEN
INSERT (
PersonID,
FirstName,
LastName,
SourceSystemKey
)
VALUES (
PersonID,
FirstName,
LastName,
SourceSystemKey
)

WHEN MATCHED THEN
UPDATE
SET
target.PersonID = source.PersonID,
target.FirstName = source.FirstName,
target.LastName = source.LastName,
target.SourceSystemKey = source.SourceSystemKey
;

END