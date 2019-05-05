param (
    [string] $resourceGroupName = "crankier",
    [string] $location = "westus2",
    [Parameter(Mandatory)]
    [string] $parameterFile,
    [string] $vmSize = "Standard_B2ms"
)

& ((Split-Path $MyInvocation.InvocationName) + "\..\CreateResourceGroup.ps1") -ResourceGroupName $resourceGroupName -Location $location

Write-Host Deploying Virtual Machine

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
    -Location $location `
    -TemplateFile .\virtualMachine.json `
    -TemplateParameterFile $parameterFile `
    -vmSize $vmSize
