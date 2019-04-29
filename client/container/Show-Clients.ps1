param(
    [string] $resourceGroupName = "crankier"
)

while ($true) {
    $clients = Get-AzContainerGroup -ResourceGroupName $resourceGroupName
    $list = New-Object System.Collections.Generic.List[System.Object]

    foreach ($client in $clients) {
        if ($client.ProvisioningState -eq "Succeeded") {

            $json = Get-AzContainerInstanceLog -ResourceGroupName crankier -ContainerGroupName $client.Name -Tail 1 
            if ($json) {
                try {
                    $object = $json | ConvertFrom-Json
                    $list.Add($object)               
                    $object | Add-Member Name $client.Name -EA SilentlyContinue
                } catch {
                    write-host $client.name: $json
                }
                
            }
        } else {
            Write-Host $client.Name $client.ProvisioningState    
        }
    }

    $list.ToArray() | Format-Table
}
