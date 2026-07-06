# sim-04-parent-process.ps1

# Project: Suspicious PowerShell Detection Engineering

# Simulation: Suspicious parent process spawning PowerShell

# Purpose: Generate harmless Sysmon Event ID 1 process creation activity

# Lab use only

Write-Host "Starting PS-004 parent-child process simulation..." -ForegroundColor Cyan

cmd.exe /c powershell.exe -NoProfile -Command "Write-Host 'SIMULATION: PowerShell spawned from cmd.exe'"

Write-Host "PS-004 simulation completed." -ForegroundColor Green
