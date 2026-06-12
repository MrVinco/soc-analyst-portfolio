# SOC Analyst Projects Portfolio

This repository contains hands-on SOC analyst projects focused on log analysis, SIEM monitoring, threat detection, phishing analysis, credential attack detection, network forensics, and MITRE ATT&CK mapping.

The goal of this portfolio is to demonstrate practical blue team skills through documented labs, screenshots, detection logic, IOC extraction, and analyst-style reports.

## Projects

| No. | Project                                                                 | Focus                                                                                |
| --- | ----------------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| 1   | [SOC Home Lab with Splunk, Sysmon, and Windows Logs](soc-home-lab/)     | SIEM setup, Windows Event Logs, Sysmon, dashboards, SPL detections                   |
| 2   | [Brute Force and Credential Attack Detection](brute-force-detection/)   | Password guessing, password spraying, credential stuffing, account lockout detection |
| 3   | [Phishing Email Analysis Portfolio](phishing-analysis/)                 | `.eml` analysis, email header review, IOC extraction, URL defanging, MITRE mapping   |
| 4   | [Network Traffic Analysis with Wireshark](wireshark-network-forensics/) | PCAP analysis, C2 beaconing detection, TShark, TCP stream review, IOC extraction     |

## Skills Demonstrated

* SOC analysis
* SIEM monitoring
* Splunk SPL
* Windows Event Log analysis
* Sysmon telemetry
* Credential attack detection
* Phishing email analysis
* Wireshark PCAP analysis
* TShark command line analysis
* IOC extraction and defanging
* MITRE ATT&CK mapping
* Incident report writing
* Security documentation

## Tools Used

| Tool                 | Purpose                                                   |
| -------------------- | --------------------------------------------------------- |
| Splunk               | SIEM log ingestion, searching, dashboards, and detections |
| Sysmon               | Endpoint telemetry collection                             |
| Windows Event Viewer | Windows Security, System, and Sysmon log review           |
| PowerShell           | Attack simulation and lab automation                      |
| Thunderbird          | Safe `.eml` email review                                  |
| Sublime Text         | Raw email header and artifact inspection                  |
| URL2PNG              | Safe suspicious URL preview                               |
| Wireshark            | Packet and PCAP analysis                                  |
| TShark               | Command line PCAP parsing                                 |
| MITRE ATT&CK         | Threat behavior mapping                                   |

## Project Safety

This repository is for defensive cybersecurity learning and portfolio development only.

The following are not uploaded:

* Malware samples
* Live phishing files
* PCAP files containing malware traffic
* Passwords or secrets
* Private challenge answers
* Sensitive local notes

Only reports, screenshots, detection files, IOC summaries, commands, filters, and documentation are included.

## Portfolio Direction

This portfolio is being built step by step to support SOC Analyst, Junior Security Analyst, Blue Team Analyst, and Cloud Security Analyst roles.
