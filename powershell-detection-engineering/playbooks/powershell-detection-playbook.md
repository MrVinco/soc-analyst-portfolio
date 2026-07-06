# PowerShell Detection Response Playbook

## Overview

This playbook provides SOC analyst response steps for suspicious PowerShell detections created in the Suspicious PowerShell Detection Engineering project.

The playbook covers five alert types:

| Alert ID | Alert Name                                    | Severity |
| -------- | --------------------------------------------- | -------- |
| PS-001   | Encoded PowerShell Command Execution          | High     |
| PS-002   | Download Cradle / Fileless Execution          | Critical |
| PS-003   | AMSI Bypass Attempt or Defender Block         | Critical |
| PS-004   | Suspicious Parent Process Spawning PowerShell | Critical |
| PS-005   | LOLBin Invocation via PowerShell              | High     |

## General SOC Triage Workflow

For every PowerShell alert, follow this process:

1. Confirm the alert fired from the correct log source.
2. Identify the affected host.
3. Identify the user account.
4. Review the command or script block content.
5. Check the parent process if Sysmon data is available.
6. Check for related network connections.
7. Check for Defender or antivirus events.
8. Decide whether the alert is benign, suspicious, or malicious.
9. Escalate if there is evidence of compromise.
10. Document the investigation.

## PS-001: Encoded PowerShell Command Execution

### Trigger Condition

PowerShell Event ID 4104 contains encoded command execution patterns such as:

* `-EncodedCommand`
* `-enc`
* `-NoProfile`
* `-NonInteractive`
* `WindowStyle Hidden`

### Severity

High

### MITRE ATT&CK

| Technique                                     | ID        |
| --------------------------------------------- | --------- |
| Command and Scripting Interpreter: PowerShell | T1059.001 |

### Initial Triage Steps

1. Review the Script Block Logging event.
2. Identify the host and user.
3. Look for the encoded string in the command.
4. Decode the Base64 payload if available.
5. Check whether the decoded payload contains download, execution, or evasion behavior.
6. Check Sysmon Event ID 1 for PowerShell process creation.
7. Check for network activity around the same timestamp.

### Helpful Splunk Searches

```spl
index=main source="WinEventLog:Microsoft-Windows-PowerShell/Operational" EventCode=4104
("encodedcommand" OR "-enc" OR "-noprofile" OR "-noninteractive" OR "windowstyle hidden")
| table _time host user EventCode _raw
| sort -_time
```

```spl
index=sysmon source="WinEventLog:Microsoft-Windows-Sysmon/Operational" EventCode=1
"powershell.exe"
| table _time host EventCode _raw
| sort -_time
```

### Decision Matrix

| Condition                                                    | Action                            |
| ------------------------------------------------------------ | --------------------------------- |
| Encoded command is known admin activity                      | Close as benign after documenting |
| Encoded command contains IEX or DownloadString               | Escalate to Critical              |
| Encoded command contains AMSI or Defender bypass strings     | Escalate to Critical              |
| Unknown user or unusual execution time                       | Escalate to Tier 2                |
| PowerShell launched from Office app, script host, or browser | Escalate to Incident Response     |

### Containment Steps if Malicious

1. Isolate the host from the network.
2. Preserve PowerShell logs.
3. Review Sysmon process tree.
4. Check for downloaded files.
5. Check for suspicious network connections.
6. Escalate to incident response.

---

## PS-002: Download Cradle / Fileless Execution

### Trigger Condition

PowerShell Event ID 4104 contains `IEX` or `Invoke-Expression` combined with download-related functions such as:

* `DownloadString`
* `DownloadFile`
* `WebClient`
* `Net.WebClient`
* `Invoke-WebRequest`
* `iwr`

### Severity

Critical

### MITRE ATT&CK

| Technique                                     | ID        |
| --------------------------------------------- | --------- |
| Command and Scripting Interpreter: PowerShell | T1059.001 |
| Ingress Tool Transfer                         | T1105     |

### Initial Triage Steps

1. Review the Script Block Logging event.
2. Extract any URL, IP address, or domain.
3. Defang the indicator before documenting it.
4. Check whether the URL is internal, localhost, or external.
5. Search for Sysmon network connection events around the same time.
6. Check whether a file was written to disk.
7. Review Defender events for detection or remediation.

### Helpful Splunk Searches

```spl
index=main source="WinEventLog:Microsoft-Windows-PowerShell/Operational" EventCode=4104
| eval script=lower(_raw)
| where (like(script,"%iex%") OR like(script,"%invoke-expression%"))
AND (
    like(script,"%downloadstring%")
    OR like(script,"%downloadfile%")
    OR like(script,"%webclient%")
    OR like(script,"%net.webclient%")
    OR like(script,"%invoke-webrequest%")
    OR like(script,"%iwr%")
)
| table _time host user EventCode _raw
| sort -_time
```

```spl
index=sysmon source="WinEventLog:Microsoft-Windows-Sysmon/Operational" EventCode=3
| table _time host EventCode _raw
| sort -_time
```

### Decision Matrix

| Condition                           | Action                                         |
| ----------------------------------- | ---------------------------------------------- |
| Localhost lab simulation            | Close as authorized simulation                 |
| External URL observed               | Escalate immediately                           |
| IEX plus download function observed | Treat as suspicious until proven benign        |
| Network connection confirmed        | Escalate to Incident Response                  |
| Defender blocked the action         | Document prevention and continue investigation |

### Containment Steps if Malicious

1. Isolate the affected host.
2. Block the URL, domain, or IP at the network layer.
3. Collect PowerShell Event ID 4104 logs.
4. Review Sysmon process and network activity.
5. Search the environment for the same URL or command.
6. Escalate to incident response.

---

## PS-003: AMSI Bypass Attempt or Defender Block

### Trigger Condition

PowerShell logs or Defender logs contain AMSI bypass-related terms or Defender block events.

Common indicators include:

* `AmsiUtils`
* `amsiInitFailed`
* `amsiContext`
* `amsi.dll`
* `Runtime.InteropServices.Marshal`
* `WriteInt32`
* `HackTool:PowerShell`
* `PsAttack`
* Defender Event ID 1116
* Defender Event ID 1117

### Severity

Critical

### MITRE ATT&CK

| Technique                                | ID        |
| ---------------------------------------- | --------- |
| Impair Defenses: Disable or Modify Tools | T1562.001 |

### Initial Triage Steps

1. Review Defender Operational logs.
2. Confirm whether Defender detected or remediated the file.
3. Review the threat name.
4. Identify the file path if available.
5. Identify the user and host.
6. Check whether the script executed or was blocked before execution.
7. Search for related PowerShell Event ID 4104 events.
8. Check for additional suspicious activity around the same timestamp.

### Helpful Splunk Searches

```spl
index=main source="WinEventLog:Microsoft-Windows-Windows Defender/Operational"
("HackTool:PowerShell" OR "PsAttack" OR "potentially unwanted software" OR "malware" OR "detected" OR "remediation")
| table _time host source EventCode _raw
| sort -_time
```

```spl
index=main source="WinEventLog:Microsoft-Windows-PowerShell/Operational" EventCode=4104
("amsiutils" OR "amsiinitfailed" OR "amsicontext" OR "amsi.dll" OR "runtime.interopservices.marshal" OR "writeint32")
| table _time host user EventCode _raw
| sort -_time
```

### Decision Matrix

| Condition                                     | Action                         |
| --------------------------------------------- | ------------------------------ |
| Defender blocked lab simulation               | Close as authorized simulation |
| Defender blocked unknown AMSI-related script  | Escalate to Tier 2             |
| AMSI bypass string appears in PowerShell logs | Escalate to Incident Response  |
| Defender action failed                        | Isolate host immediately       |
| Multiple detections from same host            | Escalate to Incident Response  |

### Containment Steps if Malicious

1. Isolate the affected host.
2. Confirm Defender remediation status.
3. Collect Defender Operational logs.
4. Collect PowerShell logs.
5. Identify the source file or script.
6. Check for persistence, lateral movement, and additional execution.
7. Escalate to incident response.

---

## PS-004: Suspicious Parent Process Spawning PowerShell

### Trigger Condition

Sysmon Event ID 1 shows suspicious parent processes spawning PowerShell.

Suspicious parent processes may include:

* `cmd.exe`
* `wscript.exe`
* `cscript.exe`
* `mshta.exe`
* `winword.exe`
* `excel.exe`
* `outlook.exe`
* `powerpnt.exe`

### Severity

Critical

### MITRE ATT&CK

| Technique                                     | ID        |
| --------------------------------------------- | --------- |
| Command and Scripting Interpreter: PowerShell | T1059.001 |

### Initial Triage Steps

1. Review Sysmon Event ID 1 process creation logs.
2. Identify the parent process.
3. Identify the PowerShell command line.
4. Check whether the parent process is expected.
5. Check if the parent is an Office application or script host.
6. Review PowerShell Event ID 4104 for script content.
7. Check for network activity or file writes around the timestamp.

### Helpful Splunk Searches

```spl
index=sysmon source="WinEventLog:Microsoft-Windows-Sysmon/Operational" EventCode=1
| eval event=lower(_raw)
| where like(event,"%powershell.exe%")
AND (
    like(event,"%cmd.exe%")
    OR like(event,"%wscript.exe%")
    OR like(event,"%cscript.exe%")
    OR like(event,"%mshta.exe%")
    OR like(event,"%winword.exe%")
    OR like(event,"%excel.exe%")
    OR like(event,"%outlook.exe%")
    OR like(event,"%powerpnt.exe%")
)
| table _time host EventCode _raw
| sort -_time
```

### Decision Matrix

| Condition                                               | Action                         |
| ------------------------------------------------------- | ------------------------------ |
| cmd.exe launching PowerShell during lab simulation      | Close as authorized simulation |
| Office app launching PowerShell                         | Escalate to Incident Response  |
| Script host launching PowerShell                        | Escalate to Tier 2             |
| PowerShell command includes download or encoded command | Escalate to Critical           |
| Parent-child relationship is expected admin activity    | Document and close as benign   |

### Containment Steps if Malicious

1. Isolate host if malicious macro or script activity is suspected.
2. Collect Sysmon Event ID 1 logs.
3. Collect PowerShell Event ID 4104 logs.
4. Identify the parent file or document.
5. Search for similar activity across other hosts.
6. Escalate to incident response.

---

## PS-005: LOLBin Invocation via PowerShell

### Trigger Condition

PowerShell invokes known Living off the Land Binaries such as:

* `certutil.exe`
* `msiexec.exe`
* `regsvr32.exe`
* `bitsadmin.exe`
* `wmic.exe`
* `mshta.exe`
* `rundll32.exe`

### Severity

High

### MITRE ATT&CK

| Technique                                     | ID        |
| --------------------------------------------- | --------- |
| System Binary Proxy Execution                 | T1218     |
| Command and Scripting Interpreter: PowerShell | T1059.001 |

### Initial Triage Steps

1. Review the PowerShell Event ID 4104 log.
2. Identify the LOLBin being called.
3. Review Sysmon Event ID 1 for process creation evidence.
4. Check the command line arguments.
5. Determine whether the binary was used for help, download, execution, or persistence.
6. Check for network activity.
7. Check for created or modified files.

### Helpful Splunk Searches

```spl
index=main source="WinEventLog:Microsoft-Windows-PowerShell/Operational" EventCode=4104
("certutil" OR "msiexec" OR "regsvr32" OR "bitsadmin" OR "wmic" OR "mshta" OR "rundll32")
| table _time host user EventCode _raw
| sort -_time
```

```spl
index=sysmon source="WinEventLog:Microsoft-Windows-Sysmon/Operational" EventCode=1
("certutil.exe" OR "msiexec.exe" OR "regsvr32.exe" OR "bitsadmin.exe" OR "wmic.exe" OR "mshta.exe" OR "rundll32.exe")
("powershell.exe" OR "pwsh.exe")
| table _time host EventCode _raw
| sort -_time
```

### Decision Matrix

| Condition                                        | Action                           |
| ------------------------------------------------ | -------------------------------- |
| LOLBin used only with help command in lab        | Close as authorized simulation   |
| certutil used to download a file                 | Escalate to Critical             |
| msiexec runs remote MSI                          | Escalate to Critical             |
| regsvr32 loads remote scriptlet                  | Escalate to Critical             |
| rundll32 or mshta executes suspicious content    | Escalate to Tier 2 or IR         |
| Known admin script with documented change ticket | Close as benign after validation |

### Containment Steps if Malicious

1. Isolate host if LOLBin was used to download or execute suspicious content.
2. Collect process creation logs.
3. Collect PowerShell script block logs.
4. Identify downloaded or executed files.
5. Search other hosts for the same command line.
6. Block related indicators.
7. Escalate to incident response.

---

## Analyst Documentation Template

Use this format when documenting a PowerShell alert:

| Field                   | Details |
| ----------------------- | ------- |
| Alert ID                |         |
| Detection Name          |         |
| Severity                |         |
| Host                    |         |
| User                    |         |
| Event Source            |         |
| Event ID                |         |
| Timestamp               |         |
| Command or Script Block |         |
| Parent Process          |         |
| Network Activity        |         |
| Defender Action         |         |
| Verdict                 |         |
| Analyst Notes           |         |

## Verdict Options

| Verdict               | Meaning                                              |
| --------------------- | ---------------------------------------------------- |
| Authorized Simulation | Activity was part of an approved lab test            |
| Benign Admin Activity | Activity was expected and approved                   |
| Suspicious            | Activity requires more investigation                 |
| Malicious             | Evidence supports compromise or attempted compromise |
| Blocked by Defender   | Security control prevented execution                 |
| False Positive        | Detection fired but activity was not risky           |

## Final Notes

PowerShell alerts should not be reviewed in isolation.

A strong SOC investigation should correlate:

* PowerShell Event ID 4104
* PowerShell Event ID 4103
* Sysmon Event ID 1
* Sysmon Event ID 3
* Windows Defender Operational events
* User context
* Host context
* Command line details
* Network connections
* File creation or modification activity

This playbook provides repeatable triage steps for suspicious PowerShell activity and supports consistent SOC analyst decision making.
