# Phishing Analysis Toolkit

## Safe Environment

All phishing analysis was performed inside a Windows 10 virtual machine. A snapshot was taken before handling the phishing sample.

## Tools Used

| Tool                  | Purpose                                                                                                                                               |
| --------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| Thunderbird           | Used as the main email viewer for safely opening and reviewing the `.eml` file, message body, recipient, subject, date, and attachment structure      |
| Sublime Text          | Used for raw email inspection and searching technical header fields such as `X-Originating-IP`, `X-PHP-Script`, `REMOTE_ADDR`, and `Received` headers |
| URL2PNG               | Used to safely preview the suspicious URL without opening it directly in a browser                                                                    |
| VirusTotal            | Used to check suspicious URLs, domains, IP addresses, and hashes                                                                                      |
| AbuseIPDB             | Used to check IP reputation and abuse reports                                                                                                         |
| MXToolbox             | Used for email header and mail server investigation                                                                                                   |
| Blue Team Labs Online | Used as the source of the phishing analysis challenge                                                                                                 |

## Safety Rules

1. Do not open suspicious links directly.
2. Do not open attachments directly.
3. Analyze `.eml` files inside the VM.
4. Use Thunderbird to review the email structure.
5. Use Sublime Text only for raw header search and technical inspection.
6. Defang all IOCs before writing reports.
7. Use `hxxp` instead of `http`.
8. Use domain format such as `example[.]com`.
9. Do not upload live phishing files to GitHub.
