param (
    [string] $resourceGroupName = "crankier",
    [string] $location = "westus2",
    [string] $parameterFile = "clientVM.parameters.secret.json",
    [string] $vmSize = "Standard_B2ms",
    [int] $number = 1
)

& ((Split-Path $MyInvocation.InvocationName) + "\..\..\CreateResourceGroup.ps1") -ResourceGroupName $resourceGroupName -Location $location

Write-Host Deploying Virtual Machine

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
    -Location $location `
    -TemplateFile .\clientVM.json `
    -TemplateParameterFile $parameterFile `
    -vmSize $vmSize `
    -number $number `
    -name vmClient-deploy-$number
