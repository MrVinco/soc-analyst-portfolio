# Phishing Email Analysis Portfolio

## Overview

This project documents phishing email analysis practice using a safe Windows virtual machine environment. The goal is to build practical SOC analyst skills by reviewing suspicious emails, inspecting headers, extracting indicators of compromise, safely previewing URLs, and writing analyst style reports.

This project is part of my hands-on cybersecurity portfolio and supports my transition into SOC analyst work.

## Lab Safety

All analysis was performed inside a Windows 10 virtual machine.

Safety rules followed:

* Suspicious links were not opened directly
* Email files were reviewed inside the VM
* Thunderbird was used to inspect `.eml` files safely
* Sublime Text was used for raw header inspection
* URLs and domains were defanged before documentation
* Live phishing samples and malicious attachments were not uploaded to GitHub
* Active lab answers and solved screenshots were kept private

## Tools Used

| Tool                  | Purpose                                 |
| --------------------- | --------------------------------------- |
| Thunderbird           | Main viewer for `.eml` email files      |
| Sublime Text          | Raw email header and content inspection |
| URL2PNG               | Safe preview of suspicious webpages     |
| WHOIS / DomainTools   | Reverse DNS and domain investigation    |
| VirusTotal            | IOC reputation checking                 |
| AbuseIPDB             | IP reputation checking                  |
| MXToolbox             | Email header and DNS investigation      |
| Blue Team Labs Online | Guided phishing analysis practice       |

## Analysis Workflow

1. Open the `.eml` file safely in Thunderbird.
2. Review the email subject, sender, recipient, body, and attachment structure.
3. Use Sublime Text to inspect raw email headers and search for technical fields.
4. Extract useful artifacts such as IP addresses, domains, URLs, hostnames, and attachment names.
5. Defang suspicious URLs and domains before documentation.
6. Use URL2PNG to preview suspicious webpages safely.
7. Use threat intelligence tools for reputation checks.
8. Map findings to MITRE ATT&CK.
9. Write a structured analyst report.
10. Update the master IOC list.

## Case Reports

| Report ID   | Case                    | Summary                                                                                         | Report                                |
| ----------- | ----------------------- | ----------------------------------------------------------------------------------------------- | ------------------------------------- |
| PA-2026-001 | Phishing Email Analysis | Email based phishing investigation using Thunderbird, Sublime Text, URL2PNG, and IOC extraction | [View Report](reports/PA-2026-001.md) |

## Indicators of Compromise

A master IOC list is maintained here:

[View IOC Master List](ioc-master-list.csv)

IOC types collected include:

* IP addresses
* Hostnames
* Domains
* URLs
* Web form source metadata

## MITRE ATT&CK Coverage

| Technique | Name                           |
| --------- | ------------------------------ |
| T1566     | Phishing                       |
| T1566.002 | Spearphishing Link             |
| T1204.001 | User Execution: Malicious Link |

## Project Structure

```text
phishing-analysis/
├── README.md
├── tools.md
├── ioc-master-list.csv
├── reports/
│   └── PA-2026-001.md
├── screenshots/
└── samples-notes/
```

## Skills Demonstrated

* Phishing email analysis
* Email header review
* IOC extraction
* URL defanging
* Safe URL previewing
* Threat intelligence enrichment
* MITRE ATT&CK mapping
* Security report writing
* SOC documentation

## Note

This project is for defensive cybersecurity learning and portfolio development only. Active challenge answers, solved screenshots, live phishing samples, and malicious attachments are not included in this public repository.
