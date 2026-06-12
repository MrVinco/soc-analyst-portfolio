\# Lab Setup Documentation



\## Overview



This document explains how the SOC home lab environment was built. The lab was created to simulate entry level SOC Analyst tasks, including log ingestion, endpoint monitoring, Windows authentication monitoring, Sysmon telemetry collection, dashboard creation, and detection engineering using Splunk.



The lab uses a Windows 10 virtual machine running in Oracle VirtualBox. Splunk Enterprise was installed locally inside the VM, and Windows Event Logs and Sysmon logs were forwarded into a custom Splunk index named `sysmon`.



\## Lab Architecture



```text

Oracle VirtualBox

Windows 10 Virtual Machine

Windows Security Logs, Windows System Logs, and Sysmon Logs

Splunk Enterprise

index=sysmon

Dashboards and Detection Rules

GitHub Documentation

```



\## Tools Used



| Tool               | Purpose                                                                                     |

| ------------------ | ------------------------------------------------------------------------------------------- |

| Oracle VirtualBox  | Virtualization platform used to host the Windows 10 VM                                      |

| Windows 10         | Endpoint used for log generation and testing                                                |

| Splunk Enterprise  | SIEM platform used for log ingestion, search, dashboards, and detection rules               |

| Sysmon             | Endpoint telemetry tool used to collect process creation, network, DNS, and system activity |

| Windows Event Logs | Source of authentication and system service events                                          |

| GitHub             | Repository used to document and publish the SOC lab project                                 |



\## Virtual Machine Setup



The lab was built using Oracle VirtualBox. A Windows 10 virtual machine was created and allocated 8 GB RAM, 4 processors, and a 50 GB virtual disk. The network adapter was configured using a bridged adapter so the VM could communicate through the host machine network.



!\[VirtualBox VM Settings](../screenshots/setup/setup-virtualbox-vm-settings.png)



The Windows 10 VM was started and used as the main endpoint for Splunk, Sysmon, and log generation.



!\[Windows VM Running](../screenshots/setup/setup-windows-vm-running.png)



\## Splunk Enterprise Setup



Splunk Enterprise was installed locally inside the Windows 10 VM and accessed through the browser at:



```text

http://localhost:8000

```



!\[Splunk Running](../screenshots/setup/setup-splunk-running.png)



\## Windows Event Log Ingestion



Splunk was configured to ingest Windows Event Logs from the local Windows 10 VM. The following log channels were selected:



```text

Security

System

Microsoft Windows Sysmon Operational

```



The logs were sent to a custom Splunk index named:



```text

sysmon

```



!\[Splunk Data Inputs](../screenshots/setup/setup-splunk-data-inputs.png)



\## Sysmon Deployment



Sysmon was installed inside the Windows 10 VM to collect endpoint telemetry. The Sysmon service was verified using the command:



```cmd

sc query Sysmon64

```



The service showed a running state, confirming that Sysmon was active.



!\[Sysmon Service Running](../screenshots/setup/setup-sysmon-service-running.png)



\## Sysmon Event Viewer Verification



Sysmon activity was also verified through Windows Event Viewer under:



```text

Applications and Services Logs

Microsoft

Windows

Sysmon

Operational

```



The Event Viewer showed Sysmon Event ID 1 process creation events, proving that Sysmon was generating telemetry.



!\[Event Viewer Sysmon Operational](../screenshots/setup/setup-event-viewer-sysmon-operational.png)



\## Splunk Source Verification



Splunk ingestion was verified with the following SPL query:



```spl

index=sysmon earliest=-24h

| stats count by source, sourcetype

| sort - count

```



The result confirmed that Splunk was receiving logs from:



```text

WinEventLog:Microsoft-Windows-Sysmon/Operational

WinEventLog:Security

WinEventLog:System

```



!\[Splunk Source Verification](../screenshots/setup/setup-splunk-source-verification.png)



\## Dashboard Creation



Four dashboards were created in Splunk:



```text

Authentication Overview

Process Execution

Network Connections

Windows SOC Detection Dashboard

```



These dashboards were used to monitor authentication failures, process execution, network connections, DNS activity, suspicious PowerShell execution, brute force login attempts, and suspicious Windows service creation.



!\[Splunk Dashboards List](../screenshots/setup/setup-splunk-dashboards-list.png)



\## Verification Summary



The setup was successfully verified through the following evidence:



| Verification Item            | Status    |

| ---------------------------- | --------- |

| Windows 10 VM created        | Completed |

| Splunk Enterprise installed  | Completed |

| Sysmon installed and running | Completed |

| Security logs ingested       | Completed |

| System logs ingested         | Completed |

| Sysmon logs ingested         | Completed |

| Dashboards created           | Completed |

| Detection rules tested       | Completed |



\## Challenges and Fixes



During the setup, Splunk caused high CPU usage when multiple dashboard searches and real time jobs were running. This was managed by stopping unnecessary real time jobs, using scheduled searches instead of real time searches, and opening one dashboard at a time.



Some Windows Security and System logs required manual field extraction using `rex` because certain fields were stored inside raw event data. The final SPL detections were adjusted to extract EventCode, usernames, source IPs, service names, and service paths from the raw log content.



\## Conclusion



This setup created a working SOC home lab environment using Oracle VirtualBox, Windows 10, Splunk Enterprise, Sysmon, and Windows Event Logs. The lab provides a practical foundation for detection engineering, dashboarding, authentication monitoring, process analysis, and incident investigation.



