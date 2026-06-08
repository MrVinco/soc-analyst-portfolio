$target = 'testuser1'
$domain = $env:COMPUTERNAME

for ($i = 1; $i -le 15; $i++) {
    $pw = ConvertTo-SecureString "wrongpass$i" -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential("$domain\$target", $pw)

    try {
        Start-Process cmd -Credential $cred -WindowStyle Hidden -ErrorAction Stop
    } catch { }

    Start-Sleep -Milliseconds 500
}

Write-Host 'Done. Check Splunk for Event ID 4625 and 4740.'