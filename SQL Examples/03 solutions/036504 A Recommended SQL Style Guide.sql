USE AdventureWorks2016

SELECT 
pod.PurchaseOrderID, 
pod.PurchaseOrderDetailID, 
pod.DueDate, 
pod.OrderQty, 
pod.ProductID, 
pod.UnitPrice, 
pod.LineTotal, 
pod.ReceivedQty, 
pod.RejectedQty, 
pod.StockedQty, 
pod.ModifiedDate, 
poh.PurchaseOrderID, 
poh.RevisionNumber, 
poh.Status, 
poh.EmployeeID, 
poh.VendorID, 
poh.ShipMethodID, 
poh.OrderDate, 
poh.ShipDate, 
poh.SubTotal, 
poh.TaxAmt, 
poh.Freight, 
poh.TotalDue, 
poh.ModifiedDate
FROM Purchasing.PurchaseOrderHeader poh
JOIN Purchasing.PurchaseOrderDetail pod
ON poh.PurchaseOrderID = pod.PurchaseOrderID