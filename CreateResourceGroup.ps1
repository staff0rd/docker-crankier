param (
    [string] $resourceGroupName = "crankier",
    [string] $location = "westus2"
)

$exists = Get-AzResourceGroup -name $resourceGroupName -EA SilentlyContinue

Write-Host "InvocationName:" $MyInvocation.InvocationName
Write-Host "Path:" $MyInvocation.MyCommand.Path

$resourceGroupTemplate = $MyInvocation.InvocationName + "\resourceGroup.json"

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