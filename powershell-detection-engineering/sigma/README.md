# Sigma Detection Rules

## Overview

This folder is reserved for Sigma versions of the PowerShell detection logic created in this project.

The current detection rules were written and tested in Splunk SPL because the lab environment uses Splunk Enterprise as the SIEM.

## Current Status

| Detection                                            | SPL Rule  | Sigma Rule |
| ---------------------------------------------------- | --------- | ---------- |
| PS-001 Encoded PowerShell Command Execution          | Completed | Planned    |
| PS-002 Download Cradle / Fileless Execution          | Completed | Planned    |
| PS-003 AMSI Bypass Attempt or Defender Block         | Completed | Planned    |
| PS-004 Suspicious Parent Process Spawning PowerShell | Completed | Planned    |
| PS-005 LOLBin Invocation via PowerShell              | Completed | Planned    |

## Planned Sigma Rules

Future Sigma rules may include:

* `PS-001-encoded-command.yml`
* `PS-002-download-cradle.yml`
* `PS-003-amsi-bypass.yml`
* `PS-004-suspicious-parent.yml`
* `PS-005-lolbin-invocation.yml`

## Why Sigma Matters

Sigma rules make detection logic portable across different SIEM platforms.

While this project uses Splunk SPL for testing, Sigma rules would allow the same detection logic to be translated for other platforms such as Elastic, Sentinel, QRadar, or other supported security tools.

## Note

The working and tested detection rules for this project are currently located in the `detections/` folder as Splunk SPL files.
