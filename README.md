# AZ300

Az300 commands and scripts

## Module 2

Create a storage account using PowerShell

```PS
Get-AzLocation | select Location
```

```PS
$location = "westeurope"
$resourceGroup = "RG-AZ300-Storage-Demo"
```

```PS
New-AzResourceGroup -Name $resourceGroup -Location $location
```

```PS
New-AzStorageAccount -ResourceGroupName $resourceGroup -Name "az300ktwdemo0227" -Location $location -SkuName Standard_LRS -Kind StorageV2
```

Create a storage account using CLI

```CLI
az group create --name RG-AZ300-Storage-Demo-cli --location westeurope
```

```CLI
az account list-locations --query "[].{Region:name}" --out table
```

```CLI
az storage account create --name az300ktwdemo0227cc --resource-group RG-AZ300-Storage-Demo-cli --location westeurope --sku Standard_LRS --kind StorageV2
```
