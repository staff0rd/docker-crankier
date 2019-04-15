param (
    [string] $resourceGroupName = "crankier"
)

Remove-AzResourceGroup -ResourceGroupName $resourceGroupName -Force
