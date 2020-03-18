# AZ300ktw

## Module2

```PS
New-AzResourceGroup -Name RG-network001-companyA -Location westeurope
New-AzResourceGroup -Name RG-network002-companyB -Location westeurope
```

```PS
New-AzVirtualNetwork -Name Vnet001CompanyA -ResourceGroupName RG-network001-companyA -AddressPrefix "10.10.10.0/24" -Location westeurope
New-AzVirtualNetwork -Name Vnet002CompanyB -ResourceGroupName RG-network002-companyB -AddressPrefix "10.101.10.0/24" -Location westeurope
```

```PS
$vnet001 = Get-AZVirtualNetwork -Name Vnet001 -ResourceGroupName RG-network001-companyA
```

```PS
Add-AZVirtualNetworkPeering -Name Vnet001toVnet002 -VirtualNetwork $vnet001 -RemoteVirtualNetworkId "vnet002ID"
```

```PS
New-AzResourceGroup -Name RG-network001-demo -Location westeurope
New-AzVirtualNetwork -Name Vnet001 -ResourceGroupName RG-network001-demo -AddressPrefix "10.10.10.0/24" -Location westeurope
New-AzVirtualNetwork -Name Vnet002 -ResourceGroupName RG-network001-demo -AddressPrefix "10.11.10.0/24" -Location westeurope
New-AzVirtualNetwork -Name Vnet003 -ResourceGroupName RG-network001-demo -AddressPrefix "10.12.10.0/24" -Location northeurope
```

### Pricing

[Vnet peering](https://azure.microsoft.com/en-us/pricing/details/virtual-network/)
