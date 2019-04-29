param (
    [string] $resourceGroupName = "crankier",
    [string] $location = "westus2",
    [Parameter(Mandatory)]
    [string] $parameterFile,
    [string] $vmSize = "Standard_B1s"
)

& ((Split-Path $MyInvocation.InvocationName) + "\..\..\CreateResourceGroup.ps1") -ResourceGroupName $resourceGroupName -Location $location

Write-Host Deploying Virtual Machine

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
    -Location $location `
    -TemplateFile .\clientVM.json `
    -TemplateParameterFile $parameterFile `
    -vmSize $vmSize
