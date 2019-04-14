param (
    [int] $count = 1,
    [int] $memory = 1,
    [int] $cpu = 1,
    [string] $resourceGroupName = "crankier",
    [Parameter(Mandatory)]
    [string] $url,
    [int] $workers = 10,
    [int] $connections = 10000
)

Enable-AzContextAutosave

For ($i=1; $i -lt $count + 1; $i++) {
    $name = "crankier-container-$i"
    $command = "dotnet run -- local --target-url $url --workers $workers --connections $connections"
    $scriptBlock = {
        param($resourceGroupName, $name, $memory, $cpu, $command)
        New-AzContainerGroup `
            -ResourceGroupName $resourceGroupName `
            -Name $name `
            -Image staff0rd/crankier `
            -MemoryInGB $memory `
            -Cpu $cpu `
            -Command $command
    }
    $job = Start-Job -ScriptBlock $scriptBlock -ArgumentList $resourceGroupName, $name, $memory, $cpu, $command
    
    Write-Host Starting $name
}
