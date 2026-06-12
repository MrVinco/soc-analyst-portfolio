# Tools Used

## Wireshark

Wireshark was used to open and inspect PCAP files visually. It helped review packet lists, protocol details, conversations, endpoints, DNS queries, HTTP requests, and TCP streams.

## TShark

TShark was used for command line PCAP analysis. It helped extract fields such as DNS queries, HTTP hosts, HTTP URIs, User Agent strings, IP addresses, timestamps, and protocol details.

TShark path used in the lab:

`C:\Program Files\Wireshark\tshark.exe`

## Npcap

Npcap was installed with Wireshark to support packet capture and network interface detection on Windows.

## VirusTotal

VirusTotal will be used to check suspicious IP addresses, domains, URLs, and file hashes.

## AbuseIPDB

AbuseIPDB will be used to check external IP reputation and abuse reports.

## URLScan.io

URLScan.io will be used to review suspicious domains and URLs safely when needed.

## Malware-Traffic-Analysis.net

Malware-Traffic-Analysis.net will be used as the main source for safe PCAP training exercises and malware traffic analysis practice.

## Lab Safety Rules

1. Analyze PCAP files only inside the Windows VM.
2. Do not upload PCAP files to GitHub.
3. Do not open live malicious URLs directly.
4. Defang all suspicious IOCs before documentation.
5. Upload only reports, screenshots, filters, commands, and IOC summaries.
6. Keep PCAP files in `C:\pcap-lab\samples\`.
