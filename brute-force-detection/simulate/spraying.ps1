$accounts = @('testuser1','testuser2','testuser3')
$domain = $env:COMPUTERNAME
$commonPw = 'Winter2024!'

foreach ($user in $accounts) {
    $pw = ConvertTo-SecureString $commonPw -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential("$domain\$user", $pw)

    try {
        Start-Process cmd -Credential $cred -WindowStyle Hidden -ErrorAction Stop
    } catch { }

    Start-Sleep -Seconds 2
}

Write-Host 'Spray complete. Check Splunk for 4625 events across testuser1, testuser2, and testuser3.'