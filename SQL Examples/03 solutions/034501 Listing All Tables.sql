USE AdventureWorks2016

SELECT
schema_name(schema_id) as schema_name,
name,
object_id,
create_date,
modify_date
FROM sys.Tables
ORDER BY name