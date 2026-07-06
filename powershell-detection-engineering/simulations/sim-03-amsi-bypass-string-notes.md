# PS-003 Simulation Notes: AMSI Bypass Attempt

## Summary

The PS-003 AMSI bypass simulation was intentionally designed to generate AMSI-related detection strings in a controlled lab environment.

When executed, Windows Defender blocked the script before it could run. This was expected behavior and was documented as a successful prevention event.

## Result

| Item                 | Result                                                     |
| -------------------- | ---------------------------------------------------------- |
| Simulation           | AMSI bypass related string generation                      |
| Execution status     | Blocked before execution                                   |
| Security control     | Windows Defender Antivirus                                 |
| Defender Event IDs   | 1116, 1117                                                 |
| Splunk source        | WinEventLog:Microsoft-Windows-Windows Defender/Operational |
| Threat name observed | HackTool:PowerShell/PsAttack.E                             |
| MITRE ATT&CK         | T1562.001                                                  |

## Analyst Note

No attempt was made to bypass or disable Windows Defender. The block was accepted as valid security control behavior.

This simulation demonstrates that AMSI bypass related content may be prevented before PowerShell Script Block Logging records the full script. In that case, Defender Operational logs become the primary evidence source.
