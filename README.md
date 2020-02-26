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
```
```
New-AzResourceGroup -Name $resourceGroup -Location $location 
```
```
New-AzStorageAccount -ResourceGroupName $resourceGroup -Name "az300ktwdemo0227" -Location $location -SkuName Standard_LRS -Kind StorageV2
```
Create a storage account using CLI
```
az group create --name RG-AZ300-Storage-Demo-cli --location westeurope
```
```
az account list-locations --query "[].{Region:name}" --out table
az storage account create --name az300ktwdemo0227cc --resource-group RG-AZ300-Storage-Demo-cli --location westeurope --sku Standard_LRS --kind StorageV2
```


