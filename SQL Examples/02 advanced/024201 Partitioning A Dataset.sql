USE AdventureWorks2016

SELECT ROW_NUMBER() OVER (PARTITION BY CarrierTrackingNumber ORDER BY CarrierTrackingNumber) AS RowNumber, CarrierTrackingNumber
FROM Sales.SalesOrderDetail
WHERE CarrierTrackingNumber IS NOT NULL