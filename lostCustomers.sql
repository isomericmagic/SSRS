SELECT 
Customer.CustID as "Customer ID",
Customer.Name as "Customer",
Customer.Address1 as "Address 1",
Customer.Address2 as "Address 2",
Customer.City as "City",
Customer.State as "State",
Customer.Zip as "Zip",
Customer.SalesRepCode as "Sales Rep Code",
SalesRep.Name as "Sales Rep",
Customer.TerritoryID as "Territory",
Customer.CreditHold as "Credit Hold",
InvcHead.InvoiceNum as "Invoice Number",
InvcHead.InvoiceDate as "Invoice Date",
InvcHead.InvoiceAmt as "Invoice Amount"
FROM Erp.Customer
INNER JOIN Erp.InvcHead ON
Customer.Company = InvcHead.Company
AND
Customer.CustNum = InvcHead.CustNum
AND InvcHead.InvoiceNum = (
SELECT TOP 1 InvcHead.InvoiceNum
FROM Erp.InvcHead 
WHERE Customer.CustNum = InvcHead.CustNum
ORDER BY InvcHead.InvoiceDate DESC)
LEFT OUTER JOIN Erp.SalesRep ON
Customer.Company = SalesRep.Company
AND
Customer.SalesRepCode = SalesRep.SalesRepCode
--WHERE InvcHead.InvoiceDate < '1/1/2017'
ORDER BY InvcHead.InvoiceDate;