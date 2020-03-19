# Module1

## Web App via CLI

```CLI
#!/bin/bash
# Replace the following URL with a public GitHub repo URL
gitrepo=https://github.com/git4jm/php-docs-hello-world.git
rgname="RG-WebAppFromGit-cli"
webappname=az300cli$RANDOM
# Create a resource group.
az group create --location westeurope --name $rgname
# Create an App Service plan in `FREE` tier.
az appservice plan create --name $webappname --resource-group $rgname --sku FREE
# Create a web app.
az webapp create --name $webappname --resource-group $rgname --plan $webappname
# Deploy code from a public GitHub repository.
az webapp deployment source config --name $webappname --resource-group $rgname --repo-url $gitrepo --branch master --manual-integration
# Copy the result of the following command into a browser to see the web app.
echo http://$webappname.azurewebsites.net
```

## Web App via PS

```PS
$gitrepo = "https://github.com/git4jm/app-service-web-html-get-started.git"
$webappname = "az300ktw$(get-random)"
$location = "westeurope"
$RgName = "RG-WebAppFromGit-ps"
New-AzResourceGroup -Name $RgName -Location $location

New-AzAppServicePlan -Name $webappname -Location $location -ResourceGroupName $RgName -Tier Free
New-AzWebApp -Name $webappname -Location $location -AppServicePlan $webappname -ResourceGroupName $RgName

$Properties = @{
    repoUrl = "$gitrepo";
    branch = "master";
    isManualIntegration = "true";
}

Set-AzResource -PropertyObject $Properties -ResourceGroupName $RgName -ResourceType Microsoft.Web/sites/sourcecontrols -ResourceName $webappname/web -ApiVersion 2015-08-01 -Force
```
