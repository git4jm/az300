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

## Module 3

Create VM via PS

```PS
$location = "westeurope"
$resourceGroup = "RG-AZ300-VM-Demo"
```

```PS
New-AzResourceGroup -Name $resourceGroup -Location $location

```

Create NIC

```
$nic = New-AzNetworkInterface -ResourceGroupName $resourceGroup -Location $location -Name psvmnic01 -SubnetID "/subscriptions/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/resourceGroups/RG-AZ300-network-001/providers/Microsoft.Network/virtualNetworks/vNet-we-hub-001/subnets/Sub1"
```

```PS
$cred = Get-Credential
```

```PS
$vm = New-AzVMConfig -VMName VM01ps -VMSize Standard_B2ms
```

```PS
$vm = Set-AzVMOperatingSystem -VM $vm -Windows -ComputerName  VM01ps -Credential $cred -ProvisionVMAgent -EnableAutoUpdate
```

```PS
$vm = Set-AzVMSourceImage -VM $vm -PublisherName MicrosoftWindowsServer -Offer WindowsServer -Skus 2016-Datacenter -Version latest
```

```PS
$vm = Set-AzVMOSDisk -VM $vm -Name myOsDisk -DiskSizeInGB 128 -CreateOption FromImage -Caching ReadWrite
```

```PS
$vm = Add-AzVMNetworkInterface -VM $vm -Id $nic.Id
```

```PS
New-AzVM -ResourceGroupName $resourceGroup -Location westeurope -VM $vm
```

## Module 4

Virtual networks

```PS
$location = "EastUS"
$resourceGroup = "RG-vNet-eus-Demo"
```

```PS
New-AzResourceGroup -Name $resourceGroup -Location $location

```

```PS
$myVNet2 = New-AzVirtualNetwork -ResourceGroupName $resourceGroup -Location EastUS -Name myVNet2 -AddressPrefix 10.0.0.0/16
```

```PS
$mySubnet2 = Add-AzVirtualNetworkSubnetConfig -Name mySubnet2 -AddressPrefix 10.0.0.0/24 -VirtualNetwork $myVNet2
```

Associate the subnet to the virtual network.

```PS
$mySubnet2 | Set-AzVirtualNetwork
```

## VM with multiple NICs

```CLI
az network vnet create --resource-group RG-vNet-eus-Demo --name myVnetcli --address-prefix 10.0.0.0/16 --subnet-name mySubnetFrontEnd --subnet-prefix 10.0.1.0/24
```

```CLI
az network vnet subnet create --resource-group RG-vNet-eus-Demo --vnet-name myVnetcli --name mySubnetBackEnd --address-prefix 10.0.2.0/24
```

```CLI
az network nsg create --resource-group RG-vNet-eus-Demo --name myNetworkSecurityGroup
```

Create NIC

```CLI
az network nic create --resource-group RG-vNet-eus-Demo --name myNic1 --vnet-name myVnetcli --subnet mySubnetFrontEnd --network-security-group myNetworkSecurityGroup
```

```CLI
az vm create --resource-group RG-vNet-eus-Demo --name myVM02 --image UbuntuLTS --size Standard_DS3_v2 --admin-username azureuser --generate-ssh-keys --nics myNic1 myNic2
```
