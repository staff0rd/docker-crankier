param (
    [string] $resourceGroupName = "crankier",
    [string] $location = "westus2",
    [string] $parameterFile = "clientVM.parameters.secret.json",
    [string] $vmSize = "Standard_B2ms",
    [int] $count = 1,
    [int] $offset = 0
)

& ((Split-Path $MyInvocation.InvocationName) + "\..\..\CreateResourceGroup.ps1") -ResourceGroupName $resourceGroupName -Location $location

Write-Host Deploying Virtual Machines

$path = $PSScriptRoot

For ($i=1; $i -lt $count + 1; $i++) {
    $number = $i + $offset

    $name = "vmClient-deploy-$number"
    
    New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
        -Location $location `
        -TemplateFile "$path\clientVM.json" `
        -TemplateParameterFile "$path\$parameterFile" `
        -vmSize $vmSize `
        -number $number `
        -name $name `
        -AsJob
        
    Write-Host Starting $name
}