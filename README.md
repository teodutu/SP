# SP
Security Protocols - UPB 2021-2022



## Labs
### Lab 1 - OpenSSL
Downloading, creating and self-signing certificates from the command line.
For creating and signing the certificate, _inspiration was drawn_ from [this](https://github.com/security-summer-school/web/tree/session-03-secure-comm/03-securing-communication) SSS-Web lab.
The code that programatically generates an unsigned certificate is mostly copy-pasted from [here](https://www.dynamsoft.com/codepool/how-to-use-openssl-to-generate-x-509-certificate-request.html).


### Lab 2 - TLS Certificates
A bunch of scripts for creating a CA certificate and using it to sign both a client and a server certificate.


### Lab 3 - VPN and IPSec Tunnels
This lab uses the scripts from the previous lab to create a TLS-based VPN between 2 VMs.
In addition, as a bonus, an IPSec VPN is also created between the same 2 VMs.


### Lab 4 - Programatic SSL/TLS
A stupid TLS client written in C and another screenshot of an `openssl s_client` command...


### Lab 5 - Wi-Fi Security
In theory, this lab teaches you how to crack Wi-Fi passwords using [aircrack-ng](https://www.aircrack-ng.org/doku.php?id=Main).
But, in reality, it's just a bunch of empty commands to be copy-pasted from the lab sheet into the terminal :(.


### Lab 6 - Google OAuth
A simple web page that uses OAuth.
It served me well in crafting [this grading script](https://github.com/teodutu/Scripts/blob/main/lab-grading/grade.py).


### Lab 7 - Discussion about Assignments
Literally nothing.


### Lab 8 - Snort
Basically a user-space iptables with a somewhat more intelligible syntax.
However, being a low-key iptables, it's still disgusting.


### Lab 9 - Offline Traffic Analysis
Wireshark and snort (bleah...) are used to analyse some `.pcap` files.
Boring...


### Courses
Various course materials (merged slides, notes from students etc) are included in the [Courses](./Courses) folder.
