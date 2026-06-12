# Network Traffic Analysis with Wireshark

## Overview

This project documents hands-on network traffic analysis using Wireshark and TShark. The goal is to investigate PCAP files, identify suspicious network behavior, extract indicators of compromise, and write clear SOC style forensic reports.

The project focuses on practical packet analysis skills used by SOC analysts, blue teamers, and network defenders.

## Objectives

The main objectives of this project are to:

* Analyze PCAP files using Wireshark
* Use TShark for command line packet analysis
* Identify suspicious DNS, HTTP, and TCP activity
* Detect possible command and control traffic
* Look for beaconing patterns
* Identify possible data exfiltration indicators
* Extract and defang IOCs
* Map findings to MITRE ATT&CK
* Write network forensic reports

## Lab Environment

Analysis was performed inside a Windows 10 virtual machine.

Tools installed:

* Wireshark
* Npcap
* TShark
* Browser for threat intelligence lookups

PCAP samples were stored locally in:

```text
C:\pcap-lab\samples\
```

PCAP files are not uploaded to GitHub.

## Tools Used

| Tool                         | Purpose                           |
| ---------------------------- | --------------------------------- |
| Wireshark                    | Visual packet analysis            |
| TShark                       | Command line PCAP parsing         |
| Npcap                        | Packet capture support on Windows |
| VirusTotal                   | IOC reputation checking           |
| AbuseIPDB                    | IP reputation checking            |
| URLScan.io                   | URL and domain review             |
| Malware-Traffic-Analysis.net | PCAP training sample source       |

## Analysis Workflow

1. Open the PCAP in Wireshark.
2. Review Protocol Hierarchy.
3. Review Conversations and Endpoints.
4. Identify internal and external IP addresses.
5. Review DNS queries.
6. Review HTTP requests.
7. Follow suspicious TCP streams.
8. Use TShark to extract timestamps, User Agents, URIs, and packet metadata.
9. Identify IOCs.
10. Defang IOCs before documentation.
11. Map findings to MITRE ATT&CK.
12. Write a structured network forensic report.

## Case Reports

| Report ID   | Focus                           | Summary                                                                                                                                        | Report                                |
| ----------- | ------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------- |
| NF-2026-001 | HTTP C2 beaconing investigation | Identified repeated HTTP POST traffic from an internal host to an external IP using `NetSupport Manager/1.3` User Agent and `/fakeurl.htm` URI | [View Report](reports/NF-2026-001.md) |

## Key Findings From NF-2026-001

The first investigation identified suspicious command and control style traffic.

Main findings:

* Internal host `10.2.28[.]88` generated repeated HTTP POST requests.
* External destination `45.131.214[.]85` was contacted repeatedly.
* Suspicious URI observed: `/fakeurl.htm`.
* User Agent observed: `NetSupport Manager/1.3`.
* POST traffic occurred at roughly regular intervals.
* Request body sizes were small, supporting C2 beaconing rather than bulk data exfiltration.
* No clear DNS tunneling was confirmed.

## Indicators of Compromise

A master IOC list is maintained here:

[View IOC Master List](ioc-master-list.csv)

IOC types collected include:

* Internal host IP
* External IP
* Suspicious URL
* Suspicious URI
* User Agent string

## MITRE ATT&CK Coverage

| Technique | Name                                      | Reason                                        |
| --------- | ----------------------------------------- | --------------------------------------------- |
| T1071.001 | Application Layer Protocol: Web Protocols | C2 traffic used HTTP POST requests            |
| T1219     | Remote Access Software                    | NetSupport Manager User Agent was observed    |
| T1105     | Ingress Tool Transfer                     | Considered as a possible supporting technique |
| T1041     | Exfiltration Over C2 Channel              | Reviewed but not confirmed                    |

## Project Files

| File                 | Purpose                              |
| -------------------- | ------------------------------------ |
| tools.md             | Tools used in the lab                |
| wireshark-filters.md | Wireshark display filter cheat sheet |
| tshark-commands.md   | TShark command reference             |
| ioc-master-list.csv  | Master IOC list across reports       |
| reports/             | Network forensic reports             |
| screenshots/         | Evidence screenshots                 |

## Skills Demonstrated

* Wireshark analysis
* TShark command line analysis
* PCAP investigation
* Protocol hierarchy review
* Conversation and endpoint analysis
* DNS analysis
* HTTP request analysis
* TCP stream review
* C2 beaconing detection
* IOC extraction and defanging
* MITRE ATT&CK mapping
* Network forensic report writing

## Safety Notice

This project is for defensive cybersecurity learning only.

PCAP files, malware samples, extracted payloads, and compressed malware archives are not uploaded to this repository. Only reports, screenshots, IOCs, filters, and commands are documented.
