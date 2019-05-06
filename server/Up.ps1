param (
    [string] $resourceGroupName = "crankier",
    [string] $location = "westus2",
    [string] $parameterFile = "virtualMachine.parameters.secret.json",
    [string] $vmSize = "Standard_D2s_v3",
    [string] $vmName = "server"
)

& ((Split-Path $MyInvocation.InvocationName) + "\..\CreateResourceGroup.ps1") -ResourceGroupName $resourceGroupName -Location $location

Write-Host Deploying Virtual Machine

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
    -Location $location `
    -TemplateFile .\virtualMachine.json `
    -TemplateParameterFile $parameterFile `
    -vmSize $vmSize `
    -vmName $vmName

& ssh-keygen -R "crankier-$vmName.westus2.cloudapp.azure.com"
