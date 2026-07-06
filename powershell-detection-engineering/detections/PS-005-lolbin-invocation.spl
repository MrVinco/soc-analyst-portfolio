# sim-05-lolbin-invocation.ps1

# Project: Suspicious PowerShell Detection Engineering

# Simulation: LOLBin invocation via PowerShell

# Purpose: Generate harmless PowerShell and Sysmon activity showing PowerShell launching certutil.exe

# Lab use only

Write-Host "Starting PS-005 LOLBin invocation simulation..." -ForegroundColor Cyan

powershell.exe -NoProfile -Command "certutil.exe /? | Out-Null; Write-Host 'SIMULATION: PowerShell invoked certutil.exe safely'"

Write-Host "PS-005 simulation completed." -ForegroundColor Green
