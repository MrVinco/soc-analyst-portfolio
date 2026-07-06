# SOC Analyst Projects Portfolio

This repository contains hands-on SOC Analyst projects focused on SIEM monitoring, Windows security logs, threat detection, phishing analysis, credential attack detection, network forensics, IOC extraction, and MITRE ATT&CK mapping.

The goal of this portfolio is to demonstrate practical blue team skills through documented labs, screenshots, detection logic, analyst-style reports, and security investigation workflows.

## Portfolio Overview

| Area                        | Focus                                                                            |
| --------------------------- | -------------------------------------------------------------------------------- |
| SIEM Monitoring             | Splunk searches, dashboards, and log analysis                                    |
| Endpoint Security           | Windows Event Logs, Sysmon, PowerShell activity, service creation                |
| Credential Attack Detection | Password guessing, password spraying, credential stuffing, account lockout       |
| Phishing Analysis           | Email header review, suspicious URL analysis, IOC extraction, safe investigation |
| Network Forensics           | Wireshark, TShark, PCAP review, HTTP traffic analysis, C2 beaconing              |
| Threat Mapping              | MITRE ATT&CK technique mapping                                                   |
| Reporting                   | Markdown-based incident reports and investigation summaries                      |

## Projects

| No. | Project                                                                 | Focus                                                                                                 |
| --- | ----------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| 1   | [SOC Home Lab with Splunk, Sysmon, and Windows Logs](soc-home-lab/)     | SIEM setup, Windows Event Logs, Sysmon, dashboards, and SPL detections                                |
| 2   | [Brute Force and Credential Attack Detection](brute-force-detection/)   | Password guessing, password spraying, credential stuffing, and account lockout detection              |
| 3   | [Phishing Email Analysis Portfolio](phishing-analysis/)                 | `.eml` review, email header analysis, IOC extraction, URL defanging, and MITRE ATT&CK mapping         |
| 4   | [Network Traffic Analysis with Wireshark](wireshark-network-forensics/) | PCAP analysis, HTTP C2 beaconing, TShark, TCP stream review, IOC extraction, and MITRE ATT&CK mapping |
| 5   | [Vulnerability Assessment and Remediation Report](vulnerability-assessment-report/) | Nessus Essentials scan, CVSS-based prioritization, vulnerability reporting, remediation planning, and evidence documentation |
| 6   | [Suspicious PowerShell Detection Engineering](powershell-detection-engineering/) | PowerShell logging, safe attack simulation, Splunk SPL detections, Sysmon analysis, Defender events, MITRE ATT&CK mapping, and SOC playbook writing |


## MITRE ATT&CK Coverage

| Project                                            | Technique ID | Technique Name           | What Was Detected / Analyzed                                            |
| -------------------------------------------------- | ------------ | ------------------------ | ----------------------------------------------------------------------- |
| SOC Home Lab with Splunk, Sysmon, and Windows Logs | T1059.001    | PowerShell               | Suspicious PowerShell execution activity using Windows and Sysmon logs  |
| SOC Home Lab with Splunk, Sysmon, and Windows Logs | T1110.001    | Password Guessing        | Multiple failed login attempts indicating brute force behavior          |
| SOC Home Lab with Splunk, Sysmon, and Windows Logs | T1543.003    | Windows Service          | Suspicious Windows service creation activity                            |
| Brute Force and Credential Attack Detection        | T1110.001    | Password Guessing        | Repeated failed login attempts against a single account                 |
| Brute Force and Credential Attack Detection        | T1110.003    | Password Spraying        | One password attempted across multiple user accounts                    |
| Brute Force and Credential Attack Detection        | T1110.004    | Credential Stuffing      | Failed logins followed by successful authentication activity            |
| Phishing Email Analysis Portfolio                  | T1566.001    | Spearphishing Attachment | Phishing email analysis involving suspicious attachment-based delivery  |
| Phishing Email Analysis Portfolio                  | T1566.002    | Spearphishing Link       | Suspicious URL extraction, defanging, and safe preview analysis         |
| Network Traffic Analysis with Wireshark            | T1071.001    | Web Protocols            | HTTP POST traffic used for suspicious command-and-control communication |
| Network Traffic Analysis with Wireshark            | T1219        | Remote Access Software   | NetSupport Manager User-Agent observed in suspicious network traffic    |
| Network Traffic Analysis with Wireshark            | T1105        | Ingress Tool Transfer    | Possible tool transfer behavior reviewed during traffic analysis        |
| Vulnerability Assessment and Remediation Report | T1595 | Active Scanning | Nessus Essentials was used to perform vulnerability discovery against an isolated lab target |
| Vulnerability Assessment and Remediation Report | T1046 | Network Service Discovery | Exposed services and ports were identified during vulnerability assessment |
| Vulnerability Assessment and Remediation Report | T1190 | Exploit Public-Facing Application | Findings included exposed vulnerable services that could be exploited if placed in a real environment |
| Vulnerability Assessment and Remediation Report | Completed |
| Suspicious PowerShell Detection Engineering | T1059.001 | PowerShell | Encoded commands, download cradle behavior, suspicious parent process execution, and PowerShell-based activity |
| Suspicious PowerShell Detection Engineering | T1105 | Ingress Tool Transfer | Download cradle pattern using IEX and DownloadString |
| Suspicious PowerShell Detection Engineering | T1562.001 | Impair Defenses: Disable or Modify Tools | AMSI-related simulation blocked by Windows Defender |
| Suspicious PowerShell Detection Engineering | T1218 | System Binary Proxy Execution | LOLBin invocation through PowerShell using certutil.exe |


## Skills Demonstrated

* SOC analysis
* SIEM monitoring
* Splunk SPL searching
* Windows Security log analysis
* Sysmon event analysis
* PowerShell activity review
* Brute force detection
* Password spray detection
* Credential stuffing detection
* Account lockout investigation
* Phishing email analysis
* Email header review
* IOC extraction and defanging
* Wireshark packet analysis
* TShark command line analysis
* TCP stream review
* C2 beaconing identification
* MITRE ATT&CK mapping
* Incident report writing
* Security documentation

## Tools Used

| Tool                 | Purpose                                                   |
| -------------------- | --------------------------------------------------------- |
| Splunk               | SIEM log ingestion, searching, dashboards, and detections |
| Sysmon               | Endpoint telemetry collection                             |
| Windows Event Viewer | Windows Security, System, and Sysmon log review           |
| PowerShell           | Lab simulation and security testing                       |
| Thunderbird          | Safe `.eml` email review                                  |
| Sublime Text         | Raw email header and artifact inspection                  |
| URL2PNG              | Safe suspicious URL preview                               |
| Wireshark            | Packet and PCAP analysis                                  |
| TShark               | Command line PCAP parsing                                 |
| MITRE ATT&CK         | Threat behavior mapping                                   |
| Markdown             | Security reports and project documentation                |
| CSV                  | IOC tracking and investigation summaries                  |

## Master IOC Tracking

A root-level IOC tracker is included to summarize indicators and artifacts across completed projects.

| File                                       | Purpose                                                                   |
| ------------------------------------------ | ------------------------------------------------------------------------- |
| [ioc-master-list.csv](ioc-master-list.csv) | Central IOC and artifact tracking across all completed portfolio projects |

The IOC tracker uses safe and defanged values where needed. Sensitive challenge answers, malware samples, phishing files, and private investigation notes are not uploaded.

## Repository Structure

| Folder / File                                                | Description                                                                     |
| ------------------------------------------------------------ | ------------------------------------------------------------------------------- |
| [soc-home-lab/](soc-home-lab/)                               | Splunk, Sysmon, Windows log monitoring, dashboards, and detection rules         |
| [brute-force-detection/](brute-force-detection/)             | Credential attack simulation, detection logic, screenshots, and incident report |
| [phishing-analysis/](phishing-analysis/)                     | Sanitized phishing email analysis workflow and public report                    |
| [wireshark-network-forensics/](wireshark-network-forensics/) | Wireshark and TShark PCAP investigation with IOC extraction                     |
| [ioc-master-list.csv](ioc-master-list.csv)                   | Root-level IOC tracker for portfolio-wide findings                              |
| README.md                                                    | Main portfolio overview                                                         |

## Project Safety

This repository is for defensive cybersecurity learning and portfolio development only.

The following are not uploaded:

* Malware samples
* Live phishing files
* Raw `.eml` phishing samples
* PCAP files containing suspicious or malicious traffic
* Passwords or secrets
* Private challenge answers
* Sensitive local notes
* Exploit code

Only reports, screenshots, detection files, IOC summaries, commands, filters, and documentation are included.

## Current Status

| Project                                            | Status    |
| -------------------------------------------------- | --------- |
| SOC Home Lab with Splunk, Sysmon, and Windows Logs | Completed |
| Brute Force and Credential Attack Detection        | Completed |
| Phishing Email Analysis Portfolio                  | Completed |
| Network Traffic Analysis with Wireshark            | Completed |
| Suspicious PowerShell Detection Engineering        | Completed |

## Future Portfolio Expansion

This portfolio will continue to grow with additional projects in:

* Vulnerability scanning and reporting
* Incident response simulation
* Threat intelligence tracking
* Detection engineering
* Cloud security monitoring
* AWS and Azure security labs
* IoT security analysis
* Security automation

## Career Focus

This portfolio is being built to support roles such as:

* SOC Analyst
* Junior Security Analyst
* Blue Team Analyst
* Cybersecurity Analyst
* Cloud Security Analyst
* Security Operations Analyst

## Contact

GitHub: [MrVinco](https://github.com/MrVinco)

Main Portfolio Repository: [SOC Analyst Projects Portfolio](https://github.com/MrVinco/soc-analyst-portfolio)
