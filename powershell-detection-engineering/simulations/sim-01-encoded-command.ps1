# sim-01-encoded-command.ps1
# Project: Suspicious PowerShell Detection Engineering
# Simulation: Encoded PowerShell command execution
# Purpose: Generate harmless encoded PowerShell activity for detection testing
# Lab use only

Write-Host "Starting PS-001 encoded command simulation..." -ForegroundColor Cyan

$command = 'Write-Host "SIMULATION: Encoded command executed" -ForegroundColor Green'
$bytes = [System.Text.Encoding]::Unicode.GetBytes($command)
$encoded = [Convert]::ToBase64String($bytes)

Write-Host "Encoded command generated:" -ForegroundColor Yellow
Write-Host $encoded

powershell.exe -NoProfile -NonInteractive -WindowStyle Hidden -EncodedCommand $encoded

Write-Host "PS-001 simulation completed." -ForegroundColor Green