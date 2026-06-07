# SOC Home Lab

## Project Overview

This project is a beginner SOC Analyst home lab built with Splunk, Windows Event Logs, and Sysmon. The lab collects endpoint and authentication logs from a Windows virtual machine, then uses Splunk dashboards and detection rules to identify suspicious activity.

The project focuses on practical SOC tasks:

Log ingestion
Security event monitoring
Sysmon process analysis
Brute force login detection
Suspicious PowerShell detection
Suspicious Windows service creation detection
Dashboard reporting
MITRE ATT&CK mapping

## Lab Environment

| Component            | Purpose                                                                                         |
| -------------------- | ----------------------------------------------------------------------------------------------- |
| Windows VM           | Endpoint used for log generation and testing                                                    |
| Splunk Enterprise    | SIEM used for log ingestion, searching, dashboards, and detections                              |
| Sysmon               | Endpoint telemetry tool used to capture process creation, network connections, and DNS activity |
| Windows Security Log | Source for failed login events                                                                  |
| Windows System Log   | Source for Windows service installation events                                                  |
| MITRE ATT&CK         | Framework used to map detections to attacker techniques                                         |

## Data Sources

The lab ingests logs into a custom Splunk index named:

```spl
index=sysmon
```

The main sources used are:

```text
WinEventLog:Security
WinEventLog:System
WinEventLog:Microsoft-Windows-Sysmon/Operational
```

## Data Flow

Windows VM activity is captured through Windows Event Logs and Sysmon. Splunk collects the logs into the sysmon index. SPL queries are then used to search, detect, and visualize suspicious behavior through dashboards.

```text
Windows VM
Windows Security Logs, System Logs, and Sysmon Logs
Splunk index=sysmon
Detection Rules
Dashboards
GitHub Documentation
```

## Detection Rules

### 1. Suspicious PowerShell Execution

This detection identifies suspicious PowerShell activity using Sysmon EventCode 1. It looks for encoded commands, no profile execution, bypass flags, download string usage, and IEX usage.

MITRE ATT&CK Mapping:

```text
T1059.001 PowerShell
```

Detection file:

```text
detections/powershell-detection.spl
```

Test result:

The detection successfully identified PowerShell execution with suspicious flags:

```text
powershell  nop  enc  dwBoAG8AYQBtAGkA
```

### 2. Brute Force Login Spike

This detection identifies repeated failed login attempts using Windows Security log event 4625. The threshold is five or more failed login attempts from the same account and source IP.

MITRE ATT&CK Mapping:

```text
T1110.001 Password Guessing
```

Detection file:

```text
detections/brute-force-detection.spl
```

Test result:

The detection successfully identified six failed login attempts from a local source.

```text
username: win10
source_ip: 127.0.0.1
failed_attempts: 6
```

### 3. Suspicious Windows Service Creation

This detection identifies suspicious Windows service creation using Windows System log event 7045. It checks for services launched from suspicious paths or using suspicious binaries such as cmd.exe, powershell, Temp, or AppData.

MITRE ATT&CK Mapping:

```text
T1543.003 Windows Service
```

Detection file:

```text
detections/new-service-detection.spl
```

Test result:

The detection successfully identified suspicious service creation activity.

```text
SOC_Test_Service
C:\Windows\System32\cmd.exe /c echo SOC test

TestService
C:\Windows\Temp\evil.exe
```

## Dashboards

### Authentication Overview Dashboard

This dashboard monitors failed login activity.

Panels included:

Failed logins over time
Top 10 accounts with failed logins
Failed logins by source IP

Screenshot:

```text
screenshots/dashboard-authentication-overview.png
```

### Process Execution Dashboard

This dashboard monitors process creation activity from Sysmon EventCode 1.

Panels included:

Process creation over time
Top parent child process pairs
Suspicious command line flags

Screenshot:

```text
screenshots/dashboard-process-execution.png
```

### Network Connections Dashboard

This dashboard monitors Sysmon network and DNS activity.

Panels included:

Connections by process
Connections on rare ports
DNS queries by process
Network connection count

Screenshot:

```text
screenshots/dashboard-network-connections.png
```

### Windows SOC Detection Dashboard

This dashboard brings the main detection evidence together in one SOC view.

Panels included:

Suspicious PowerShell Execution
Brute Force Login Spike
Suspicious Windows Service Creation
Suspicious PowerShell Count
Failed Login Count
New Service Count
Log Volume Over Time
Recent Process Creation Events

Screenshot:

```text
screenshots/dashboard-detection-rules.png
```

Cropped summary screenshot:

```text
screenshots/dashboard-detection-rules-summary.png
```

## Repository Structure

```text
soc-home-lab/
README.md
config/
  sysmonconfig-export.xml
detections/
  powershell-detection.spl
  brute-force-detection.spl
  new-service-detection.spl
dashboards/
  authentication-overview-dashboard.xml
  process-execution-dashboard.xml
  network-connections-dashboard.xml
  windows-soc-detection-dashboard.xml
screenshots/
  dashboard-authentication-overview.png
  dashboard-process-execution.png
  dashboard-network-connections.png
  dashboard-detection-rules.png
  dashboard-detection-rules-summary.png
```

## Skills Demonstrated

Splunk search and reporting
Windows Event Log analysis
Sysmon log analysis
SPL query writing
Dashboard creation
Detection engineering fundamentals
MITRE ATT&CK mapping
Authentication monitoring
Process execution analysis
Network activity monitoring
Incident documentation

## Limitations

This lab was built on a single Windows virtual machine, so detection coverage is limited to local endpoint activity. The test activity was simulated in a controlled lab environment. Some fields required manual extraction using rex because the logs were not fully normalized. In a production SOC, these detections should be tuned further to reduce false positives and adapted to match the organization’s real log sources and field names.

## Conclusion

This SOC home lab demonstrates practical entry level security monitoring skills using Splunk, Windows Event Logs, and Sysmon. The project shows the ability to ingest logs, create dashboards, build detection rules, test simulated attack behavior, and document findings with MITRE ATT&CK mapping.

## References

Microsoft Corporation. (2024). Sysmon. Microsoft Sysinternals. Microsoft Corporation.

Microsoft Corporation. (2024). Windows security auditing event 4625: An account failed to log on. Microsoft Corporation.

MITRE Corporation. (2025). Brute force: Password guessing, sub technique T1110.001. MITRE ATT&CK. MITRE Corporation.

MITRE Corporation. (2025). Command and scripting interpreter: PowerShell, sub technique T1059.001. MITRE ATT&CK. MITRE Corporation.

MITRE Corporation. (2025). Create or modify system process: Windows service, sub technique T1543.003. MITRE ATT&CK. MITRE Corporation.

Splunk LLC. (2025). Splunk Enterprise Search Reference. Splunk LLC.
