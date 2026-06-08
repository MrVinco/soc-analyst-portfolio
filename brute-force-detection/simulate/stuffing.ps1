net user testuser2 LabPassword123!

$domain = $env:COMPUTERNAME

foreach ($i in 1..3) {
    $pw = ConvertTo-SecureString "wrongpass$i" -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential("$domain\testuser2", $pw)

    try {
        Start-Process cmd -Credential $cred -WindowStyle Hidden -ErrorAction Stop
    } catch { }

    Start-Sleep -Seconds 1
}

$pw = ConvertTo-SecureString "LabPassword123!" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("$domain\testuser2", $pw)

try {
    Start-Process cmd -Credential $cred -WindowStyle Hidden -ErrorAction Stop
} catch { }

Write-Host 'Credential stuffing simulation complete. Check Splunk for 4625 followed by 4624 for testuser2.'