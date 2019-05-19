param (
    [string] $resourceGroupName = "crankier",
    [string] $vmNamePrefix = "crankier",
    [string] $command = "printenv"
)

$vms = Get-AzVM
$password = "mypassword" | ConvertTo-SecureString -asPlainText -Force
$username = "crankier"
$credential = New-Object System.Management.Automation.PSCredential($username,$password)

$addresses = Get-AzPublicIpAddress | select -ExpandProperty DnsSettings | select -ExpandProperty Fqdn | where {$_.Contains("client")}
[System.Collections.ArrayList]$jobs = @()
$blockSize = 5
$count = $addresses.Count / $blockSize
#Write-Host $count in $addresses.Count
for ($i = 0 ; $i -le $count; $i++) {
    #Write-Host i = $i
    $start = $i*$blockSize
    $end = $start + $blockSize-1

    foreach ($fqdn in $addresses[$start..$end]) {
        #Write-Host $fqdn
        $job = Start-Job -ScriptBlock {
            param([string]$fqdn, [System.Management.Automation.PSCredential] $credential, [string] $command)
            Remove-SSHTrustedHost $fqdn
            $session = New-SSHSession -ComputerName $fqdn -KeyFile ~\.ssh\id_rsa -credential $credential -AcceptKey
            Write-Host sesion is up
            $result = Invoke-SSHCommand $session $command
            Write-Host command is invoked
            Write-Host $result.Output
            if ((Remove-SSHSession $session) -eq $true) {
            } else {
                Write-Host Could not close $session
            }
        } `
        -ArgumentList $fqdn, $credential, $command
        $length = $jobs.Add($job)
    }

    while ($jobs.Count -gt 0) {
        $job = $jobs | Wait-Job -Any
        $data = Receive-Job $job
        Write-Host $data
        $jobs.Remove($job)
    }
}
