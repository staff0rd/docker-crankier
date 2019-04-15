param (
    [string] $resourceGroupName = "crankier",
    [string] $location = "westus2",
    [Parameter(Mandatory)]
    [string] $parameterFile,
    [string] $vmSize = "Standard_B1s"
)

$exists = Get-AzResourceGroup -name $resourceGroupName

if (-Not $exists) {
    Write-Host Creating resource group $resourceGroupName
    New-AzDeployment 
        -TemplateFile .\resourceGroup.json `
        -Location $location -ResourceGroupName $resourceGroupName -ResourceGroupLocation $location
}
Else {
    Write-Host Resource group $resourceGroupName already exists
}

Write-Host Deploying Virtual Machine

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
    -Location $location `
    -TemplateFile .\virtualMachine.json `
    -TemplateParameterFile $parameterFile `
    -vmSize $vmSize
