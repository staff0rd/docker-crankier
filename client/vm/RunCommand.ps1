param (
    [string] $resourceGroupName = "crankier",
    [string] $vmNamePrefix = "crankier",
    [Parameter(Mandatory)]
    [string] $command
)

$vms = Get-AzVM
$password = "mypassword" | ConvertTo-SecureString -asPlainText -Force
$username = "crankier"
$credential = New-Object System.Management.Automation.PSCredential($username,$password)

Get-AzPublicIpAddress | select -ExpandProperty DnsSettings | select -Property Fqdn

foreach ($vm in $vms) {
    if ($vm.Name.StartsWith($vmNamePrefix)) {
        $prefix = $vm.Name.replace("-vm", "")
        $fqdn = (Get-AzPublicIpAddress -Name "$prefix-ip" -ResourceGroupName $resourceGroupName).DnsSettings.Fqdn
        #write-host $fqdn
        Remove-SSHTrustedHost $fqdn
        $session = New-SSHSession -ComputerName $fqdn -KeyFile ~\.ssh\id_rsa -credential $credential -AcceptKey
        $result = Invoke-SSHCommand $session $command
        Write-Host $result.Output
        if ((Remove-SSHSession $session) -eq $true) {
        } else {
            Write-Host Could not close $session
        }
    }
}
