# AZ300
Az300 commands and scripts
##Module 2
Create a storage account using PowerShell
```PS
Get-AzLocation | select Location
```
```
$location = "westeurope"
$resourceGroup = "RG-AZ300-Storage-Demo"
New-AzResourceGroup -Name $resourceGroup -Location $location 
New-AzStorageAccount -ResourceGroupName $resourceGroup -Name "storagedemo" -Location $location -SkuName Standard_LRS -Kind StorageV2
```
