select 
[POHeader].[PONum] as [PONum],
[POHeader].[EntryPerson] as [EntryPerson],
[POHeader].[OrderDate] as [OrderDate],
[PODetail].[POLine] as [POLine],
[PODetail].[PartNum] as [PartNum],
[PODetail].[LineDesc] as [LineDesc],
[PODetail].[OrderQty] as [OrderQty],
[PORel].[RelQty] as [RelQty],
[PORel].[DueDate] as [RelDate],
[PORel].[ReqChgDate] as [ReqChgDate],
[Vendor].[VendorID] as [VendorID],
[Vendor].[Name] as [VendorName]
from Erp.POHeader as POHeader
inner join Erp.PODetail as PODetail on
POHeader.Company = PODetail.Company 
and
POHeader.PONum = PODetail.PONUM 
inner join Erp.PORel as PORel on
PODetail.Company = PORel.Company 
and
PODetail.PONum = PORel.PONum
and 
PODetail.POLine = PORel.POLine
inner join Erp.Vendor as Vendor on
POHeader.Company = Vendor.Company 
and
POHeader.VendorNum = Vendor.VendorNum
where [POHeader].[OrderDate] >= DATEADD(MONTH, -3, GETDATE()) 



