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
