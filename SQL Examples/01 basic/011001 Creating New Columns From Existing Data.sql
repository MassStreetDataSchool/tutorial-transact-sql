USE AdventureWorks2016

SELECT
OrderQty,
UnitPrice,
UnitPriceDiscount,
LineTotal,
OrderQty * (UnitPrice - UnitPriceDiscount) AS CalculatedLineTotal
FROM Sales.SalesOrderDetail