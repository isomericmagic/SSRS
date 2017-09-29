select
    [Part].[ClassID] as [Part_ClassID],
	[PartClass].[Description] as [Part_Class_Description],
	[Part].[PartNum] as [Part_PartNum],
	[Part].[PartDescription] as [Part_PartDescription],
	[Part].[UnitPrice] as [Part_UnitPrice],
	sum([PartWhse].[OnHandQty]) as [PartWhse_OnHandQty],
	--[PartWhse].[WarehouseCode] as [PartWhse_WarehouseCode],
	(PartCost.StdLaborCost + PartCost.StdBurdenCost + PartCost.StdMaterialCost + PartCost.StdSubContCost + PartCost.StdMtlBurCost) as [Standard_Cost],
	(PartCost.AvgLaborCost + PartCost.AvgBurdenCost + PartCost.AvgMaterialCost + PartCost.AvgSubContCost + PartCost.AvgMtlBurCost) as [Average_Cost]
from Erp.Part as Part
inner join Erp.PartCost as PartCost on (
	Part.Company = PartCost.Company
And
	Part.PartNum = PartCost.PartNum
)
inner join Erp.PartWhse as PartWhse on 
	Part.Company = PartWhse.Company
And
	Part.PartNum = PartWhse.PartNum
 and ( (Part.PartNum <> 'MISC ITEM'  and Part.PartNum <> 'MISC ITEMS'  and Part.PartNum <> 'MISC SERVICE' ) )
inner join Erp.PartClass as PartClass on
	Part.Company = PartClass.Company
And 
	Part.ClassID = PartClass.ClassID

 where (PartWhse.WarehouseCode = 'B' OR PartWhse.WarehouseCode = 'BAR' OR PartWhse.WarehouseCode = 'F' OR PartWhse.WarehouseCode = 'F9' OR PartWhse.WarehouseCode = 'N' OR PartWhse.WarehouseCode = 'V' OR PartWhse.WarehouseCode = 'Z')
 group by [Part].[ClassID], [PartClass].[Description], [Part].[PartNum], [Part].[PartDescription], [Part].[UnitPrice], (PartCost.StdLaborCost + PartCost.StdBurdenCost + PartCost.StdMaterialCost + PartCost.StdSubContCost + PartCost.StdMtlBurCost), (PartCost.AvgLaborCost + PartCost.AvgBurdenCost + PartCost.AvgMaterialCost + PartCost.AvgSubContCost + PartCost.AvgMtlBurCost)