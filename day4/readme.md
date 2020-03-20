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

# Module 3

## AKS

```CLI
rg="RG-AKS-001"
aksname="AKSCluster001"
az group create --name $rg --location westeurope
```

Create cluster

```CLI
az aks create --resource-group $rg --name $aksname --node-count 2 --enable-addons monitoring --generate-ssh-keys
```

Get cred

```CLI
az aks get-credentials --resource-group $rg --name $aksname
```

Get a list of cluster nodes

```CLI
kubectl get nodes
```

```YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  name: azure-vote-back
spec:
  replicas: 1
  selector:
    matchLabels:
      app: azure-vote-back
  template:
    metadata:
      labels:
        app: azure-vote-back
    spec:
      nodeSelector:
        "beta.kubernetes.io/os": linux
      containers:
      - name: azure-vote-back
        image: redis
        resources:
          requests:
            cpu: 100m
            memory: 128Mi
          limits:
            cpu: 250m
            memory: 256Mi
        ports:
        - containerPort: 6379
          name: redis
---
apiVersion: v1
kind: Service
metadata:
  name: azure-vote-back
spec:
  ports:
  - port: 6379
  selector:
    app: azure-vote-back
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: azure-vote-front
spec:
  replicas: 1
  selector:
    matchLabels:
      app: azure-vote-front
  template:
    metadata:
      labels:
        app: azure-vote-front
    spec:
      nodeSelector:
        "beta.kubernetes.io/os": linux
      containers:
      - name: azure-vote-front
        image: microsoft/azure-vote-front:v1
        resources:
          requests:
            cpu: 100m
            memory: 128Mi
          limits:
            cpu: 250m
            memory: 256Mi
        ports:
        - containerPort: 80
        env:
        - name: REDIS
          value: "azure-vote-back"
---
apiVersion: v1
kind: Service
metadata:
  name: azure-vote-front
spec:
  type: LoadBalancer
  ports:
  - port: 80
  selector:
    app: azure-vote-front
```

Deploy app

```CLI
kubectl apply -f azure-vote.yaml
```

check status

```CLI
kubectl get service azure-vote-back --watch
```

get pods related with app

```CLI
kubectl get pods
kubectl get service
```

dashboard

```CLI
az aks browse --resource-group $rg --name $aksname
```

<https://github.com/MicrosoftDocs/azure-docs/blob/master/articles/aks/kubernetes-walkthrough.md>

<https://github.com/Azure/dev-spaces/tree/master/samples/BikeSharingApp>
<https://docs.microsoft.com/en-us/azure/dev-spaces/quickstart-team-development>

<https://github.com/MicrosoftDocs/azure-docs/blob/master/articles/aks/kubernetes-dashboard.md>

Dev spaces
<https://docs.microsoft.com/en-us/azure/dev-spaces/quickstart-team-development?toc=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fazure%2Faks%2Ftoc.json&bc=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fazure%2Fbread%2Ftoc.json>

```CLI
az aks use-dev-spaces -g MyResourceGroup -n MyAKS --space dev --yes
```

## Create a container registry

```CLI
rg="RG-AKS-001"
acrname="ktwcontainerregistry00jm"
az acr create --resource-group $rg --name $acrname --sku Basic

```

Login

```CLI
az acr login --name $acrname

```

Pull existing Docker image

```CLI
docker pull microsoft/aci-helloworld
```

Tag image with full login server name prefix
docker tag microsoft/aci-helloworld ktwcontainerregistry00jm/aci-helloworld:v1

## Install stuff on Azure VM

```PS
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install azure-cli docker-desktop googlechrome git -y
```
