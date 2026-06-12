# Wireshark Display Filters

## Basic Protocol Filters

```text
http
dns
tcp
udp
tls
icmp
```

## IP Filters

```text
ip.addr == 192.168.1.5
ip.src == 192.168.1.5
ip.dst == 8.8.8.8
not ip.addr == 192.168.1.1
```

## Port Filters

```text
tcp.port == 80
tcp.port == 443
tcp.port == 8080
tcp.dstport == 443
udp.port == 53
```

## HTTP Filters

```text
http.request
http.request.method == "GET"
http.request.method == "POST"
http.host
http.user_agent
http contains "password"
```

## DNS Filters

```text
dns
dns.flags.response == 0
dns.qry.name
dns.qry.name contains "login"
```

## C2 Detection Filters

```text
ip.addr == [suspicious_ip]
http.request.uri contains "gate"
http.request.uri contains "check"
http.user_agent contains "curl"
tcp.flags.syn == 1 and tcp.flags.ack == 0
```

## DNS Tunneling Filters

```text
dns and frame.len > 100
dns.flags.response == 0
dns.qry.name matches "[A-Za-z0-9]{30,}"
```

## Exfiltration Filters

```text
http.request.method == "POST"
ftp-data
tcp.len > 1000
tcp.len > 1000 and not ip.dst == [internal_subnet]
```

## Noise Reduction Filters

```text
not arp
not dns
not mdns
not nbns
not ssdp
not (udp.port == 5353)
not (ip.addr == 239.255.255.250)
```
