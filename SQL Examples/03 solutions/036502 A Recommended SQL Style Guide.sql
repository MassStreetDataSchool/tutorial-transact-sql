USE AdventureWorks2016

SELECT PurchaseOrderID, SUM(LineTotal) AS LineTotalSum
FROM Purchasing.PurchaseOrderDetail
WHERE OrderQty > 100
GROUP BY PurchaseOrderID
ORDER BY PurchaseOrderID