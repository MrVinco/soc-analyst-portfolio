# sim-03-amsi-bypass-string.ps1

# Project: Suspicious PowerShell Detection Engineering

# Simulation: AMSI bypass string detection

# Purpose: Generate harmless AMSI bypass-related strings for detection testing

# Lab use only

# This script does NOT disable AMSI or patch memory.

Write-Host "Starting PS-003 AMSI bypass string simulation..." -ForegroundColor Cyan

$amsiString1 = 'System.Management.Automation.AmsiUtils'
$amsiString2 = 'amsiInitFailed'
$amsiString3 = 'amsiContext'
$amsiString4 = 'amsi.dll'
$amsiString5 = 'Runtime.InteropServices.Marshal'
$amsiString6 = 'WriteInt32'

Write-Host "SIMULATION: AMSI-related strings generated for detection testing"
Write-Host $amsiString1
Write-Host $amsiString2
Write-Host $amsiString3
Write-Host $amsiString4
Write-Host $amsiString5
Write-Host $amsiString6

Write-Host "PS-003 simulation completed." -ForegroundColor Green
