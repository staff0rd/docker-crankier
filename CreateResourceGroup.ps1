param (
    [string] $resourceGroupName = "crankier",
    [string] $location = "westus2"
)

$exists = Get-AzResourceGroup -name $resourceGroupName -EA SilentlyContinue

$resourceGroupTemplate = "$PSScriptRoot\resourceGroup.json"

if (-Not $exists) {
    Write-Host Creating resource group $resourceGroupName
    New-AzDeployment `
        -TemplateFile $resourceGroupTemplate `
        -Location $location `
        -ResourceGroupName $resourceGroupName `
        -ResourceGroupLocation $location
}
Else {
    Write-Host Resource group $resourceGroupName already exists
}