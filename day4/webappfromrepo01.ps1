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


