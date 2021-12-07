Catalin Leordeanu
Elena Apostol 
Razvan Popa - laborator
Lab Tuesday 16-18
    Wednesday 18-20

We will have an Essay/Homework and 2 quizzes. 
Topics: Access Control, SSL/TLS, Internet Security, Wireles Security, IPS/IDS

Half of the total points to pass the class. 

Points: Lab 2, HW 3, Quizz(~week 7 and week 14) 1, Final exam 4


**Security policy** = a specification of what is allowed and what is not
**Security mechanism** = a method or tool used to enforce a ploicy
			i.e encryption, authentication, authorization, audit, and others. Essentially anything technical

**CIA triad**: 
-Confidentiality(allow access only to authorized users),
-Integrity (data has not been altered), 
-Availability(use data/resources when you need).

Attacks: Interception, Modification, Fabrication, Interruption.

**Reconn attacks**: packet sniffer, port scanning, ping sweeping
**Access attacks** : attacks on secret code, utilization of trust port, social engineering, port redirection, MITM
**Denial of service**: Host based, Network based, Distributed

* [Hackmageddon](https://www.hackmageddon.com)/ - **Check it out**

## Cryptology

Cryptology = Cryptography + Cryptanalysis
**Symmetric encryption** = same key to encrypt and decrypt. i.e AES
			Vulnerability: How do you share the key?
**Asymmetric encryption** = different keys. Encryption key is also public. The decryption key is private. i.e RSA

**Digital signatures** = Alice encrypts the message using her private key. Bob decrypts the message using Alice's public key. If the decryption is sucessful then Bob knows it is from Alice.


**Digital certificates** = acts as a trusted party for authentication. It is issued by a Certificate Authority (CA) and is created according to the X.509 standard


## Methods of authentication
There are 3 categories:
1. **Ownership** = something you own/posses
2. **Knowledge** = something you know
3. **Inherence** = something you are


Forms: 
1. **Basic authentication** = some sort of credentials
2. **Challenge-response** = a server/authenticating system generates a challenge and expects a response
3. **Centralized authentication** = a central server authenticates uses and also authorizes and audits them.

##Authorization

What permission a user has after authentication.
**Authentication + Authorization = Access Control**
Minimum privilege principle : only the minimum set of rights must be given to a user

Types of access control:
1. **Discretionary Access Control (DAC)**:
The owner decides who has access to a resource.
Easy to use in small environments.

2. **Mandatory Access Control (MAC)**:
Each resource has a tag. Each user has a certain access level. If the user has an access level at least equal to the resource tag then the access is allowed.

3. **Non-Discrectionary/Role based(RBAC)**:
Each user has access to a resource based on a role which was assigned to him
Individual -> Role -> Resource
The users change but, the roles usually don't.
Types of RBAC:
1. Flat RBAC: the one described above
2. Hierarchical RBAC: A role can have access to lower roles based on the hierarchy.
3. RBAC with constraints. Types of constraints: mutually exclusive roles/permissions, cardinality (number of roles), prerequisite roles

# Communication protocols basic info


The transport layer ensures communication between processes. It creates a link between processes and network access points. 
An access point is identified through *<network address, port>*.

**Socket API**
 - identified by a file descriptor
 - it is the standard

\*know UDP and TCP

## PPP, PAP, CHAP protocols

These protocols are old but some of their elements are still used.

**PPP (Point to Point Protocol)***

It was used to send data through a dedicated link
It can negotiate the establishment of a link and the exchange
It can encapsulate data in the data link layer
It does very basic authentication

Frame Format:
   - flag
   - address: it is always broadcast because it is point to point
	- control
	- data
	- FCS
	- Flag

**Password authentication protocol (PAP)**

Send user name and pass. The server checks and accepts or dennies.
If the traffic is intercepted, the protocol gets corrupted.
It was designed for 2 hosts connected point to point.
It has a value of C023 in PPP frame.

Three PAP-packest:
 1. Authenticate-request
 2. Authenticate-ack
 3. Authenticate-nak


**Challenge handshake authentication protocol (CHAP)**

The password is never sent online.
The server sends a challenge packet, usually a few bytes. The user responds to the challenge. The server does the same as the user and then compares the results.
It has a field value of C223 in the PPP frame.
Four packets:
1. Challenge
2. Response
3. Success
4. Failure 

## IP security (IPSec)

It creates a unidirectional link between the sender and the receiver. It does this through *Security Association (SA)*
Ensures one of the following: message authentication, or authentication and encryption
The SA is not tied to a single encryption algorithm.
Any endpoint using IPSec has to create a db for all SAs. It includes multiple security parameters and counter for seq number, overflow indicator, anti-replay window, and path MTU. 
Each entry in the SA db is identified using:
- Security Parameters Index (SPI)
- IP Destination Address
- Security Protocol Identifier

Two security procols: 
1. Authentication Header (AH): it only authenticates data
It is inserted between the IP header and TCP header. 
It uses *Hashed Message Authentication Code (HMAC)*. This uses a symmetric key. **Hash = datagram + symmetric key**

2. Encapsulation Security Payload (ESP): authentication and encryption (although yoyu cannot encrypt everything).
 - Transport mode: the header is placed between the IP and TCP Headers. The TCP Header and payload are encrypted.
 - tunnel mode: the header is added with a new IP header. The old IP header goes between ESP and TCP headers. These 3 are encrypted. The tunnel can end before the final destination.


Two modes:
1. Tunnels
2. Transport

## Key management

Diffie-Helman key exchange:
- x is the private key
- *g^x mod n* is the public key
- *K(A,B) = g^xy mod n* is the secret key shared with Bob
\* It is vulnerable to MITM attack.

Internet Key Exchange (IKE) is based on Diffie-Helman and it is used in IPsec.
**IKEv1**:
- Phase 1:
1. a client initiates the IKE SA request
2. Identities are sent
3. Diffie-Hellman Key Exchange
- Phase 2:
1. The SA is established and protected
2. SA parameters are renegociated after a set duration (session).

**IKEv2**:
The authentication step is also encrypted. 
Can support different authentication protocols

IPv6 advantages over IPv4:
- Huge address range. No need of NAT
- IPSec support is mandatory (not the usage)
- Built-in Security headers

 ## Firewalls

Block, filter, modify traffic at the network layer
Actions: inspect traffic, allow traffic specified in a policy, drops everything else

Two types:
1. **Packet Filters**
Usually done within a router between external and internal network.
Check Packet Header Fields (IP source and destination)
Possible actions: allow a packet, drop a packet, alter the packet (NAT), log info about the packet

**Ingress filtering**: packets coming from outside going inside
**Egress filtering**: packets from inside going outside of the network

Typical Firewall Config : Internal hosts can access DMZ and Internet, External hosts can access DMZ only, DMZ hosts can access Internet only. You do this so that your internal network is not exposed.

Firewall implementation:
1. Stateless packet filters: each packet is treated individually. Condition met -> action taken
Advantages: Transparent to application/user, can be efficient
Disadvantages: Usually fail open (rules configured correctly), very hard to configure
2. Stateful packet filters : Keep the connection states

2. **Proxies**
It is fail cosed: it has a connection to the server and one to the client
Better logging.
It doesn't perform very well
One proxy needed for each application

## VPNs

A VPN carries traffic over a public network using encryption and tunnels to protect the confidentiality of info, integrity of data, and authentication of users
VPNs can be built at any layer of the OSI protocol stack. It is usually built over IPsec or over SSL/TLS

Three critical functions: 
- Confidentiality
- Data integrity
- Origin authentication

## WiFi Security
802.11n used packet aggregation (a single header for multiple data packets). Also uses MIMO (Multiple Input Multiple Output)

Security Threats: 
- Disclosure Threat: information is easily leaked to an unwanted party. The transmission medium is by definition broadcast only
- Integrity threat: There may be unauthorized changes of information during transmission
- Denial of service: The transmission frequencies can be easily saturated by outsied traffic or white noise
- There is no centralized, trusted third party for a wireless network

The AP constantly broadcast the SSID. This is a security issue. The solution is to turn off the SSID broadcasting (useless though). The AP still sends beacon messages to chek if the connection is alive. The beacon message contains the SSID.

**WEP** = Wired Equivalent Privacy. It used a symmetric RC4 encryption algorithm with an IV. When a client is connecting the AP checks if C knows the secret key (challenge request). 
The AP uses the same key for all traffic so this makes it vulnerable. You can use aircrack-ng in Kali to break this. 

**WPA** = Wi-Fi Protected Access. It uses TKIP (Temporary Key Integrity Protocol 128 bit). It uses a different key for every packet. It uses a session key which is regenerated after a pre-set time.
  Personal WPA - using a pre-shared key
  Enterprise WPA - using a RADIUS server
WPA 1 uses DES
WPA 2 uses AES

**WPS** it was created for simple usage. It uses a PIN, Push-button, or Near-field communication to secure the connection. It is easy to crack (even with brute-force). There is also a tool *reaver*

# SSL/TLS

**SSL** = secure sockets layer (v3 is good)
**TLS** = transport layer security (1.0 is SSL3.0 with minor tweaks). It is open source

SSL/TLS provides security at TCP layer (transport)

### Security Goals

Entity authentication of participating parties:
 - participants are servers and clients
 - servers are almost always authenticated, clients less often
 - good for e-commerge applications

Establishment of a fresh, shared secret:
 - shared secret used to derive further keys
 - for confidentiality and auth in SSL Record Protocol

Secure ciphersuite negotiation:
 - Encryption and hash algorithms
 - Authentication and key establishment methods


### Basic Features

SSL is a layered protocol
SSL takes messages, fragments them in blocks, compresses the data (optional), applies MAC, encrypts, and transmits
Received data is decrypted, verified, decompressed, and reassembled, then delivered to higher level clients
Connects on 443 by default
Session identifier cache timeout is 100 seconds

COnfidentiality: encrypt data being sent, so that passive wiretapper cannot read data
Integrity: protect against modification of messages 
Authentication

### SSL components

1. SSL Handshake protocol: negotiation of security algorithms and parameters, key exchange, server auth and optionally client auth
2. SSL Record Protocol : fragmentation, compression, message auth and integrity protection, encryption
3. SSL Change Cipher Spec Protocol: a single message that indicates the end of the SSL handshake
4. SSL Alert Protocol: error messages

#### Sessions and connections
An SSL Session = an association between a client and a server
Sessions are stateful
A session may include multiple secure connections. Normally you have only one connection between a client and a server
Connections of the same session share the session parameters

Parameters for session:
 - state
 -  identifier
 - peer certificate
 - compression method
 - cipher spec
 - master secret (48 byte shared between the client and server)
 - is resumable (it can be used to initiate new connections)
 - connection state

Parameters for connection:
 - server and client random
 - server write MAC secret (used in MAC operations)
 - client write MAC secret (used in MAC operations)
 - server write key (encryption key for server)
 - client write key (encryption key for client)
 - initialization vectors
 - sequence numbers for sending and receiving data


State Changes:
1. Operating state: currently used
2. Pending state: state to be used
3. Operating state : at the transmission and reception of a Change Cipher Spec message


**SSL Record Protocol**
Provides secure, reliable channel to upper layer
Provides data authentication and integrity 
It also provides Confidentiality using a symmetric key algorithm

**Encryption**
You can use block ciphers(padding is applied), stream ciphers 

**SSL Alert Protocol**
2 bytes: first byte (warning, or fatal), second byte (id)
In case of a fatal aler the connection is terminated, and session ID is invalidated.

**SSL Handshake Protcol**
1. Client sends hello message (random, protocol, sessionID, cipher suite, compression method)
2. Server replies with hello (own protocols, random message, its certificate, and requests for client cert if needed)
3. CLient authenticates the server and creates a pre-master secret, and sends an encrypted message (with the server's public key)
4. Server authenticates the client if necessary, uses its private key to decode the message and the pre-master secret, then creates a master secrety key for the session and tells the client about the key.
5. Client decodes the master key and tells the server it will use it to encode the session
6. Handshake is done.

We can split the steps into phases:
1. client and server hello
2. certificate (optional), server_key_exchange (optional), certificate_request (optional), server_hello_done
3. certificate (optional), client_key_exchange, certificate_verify (optional)
4. change_cipher_spec, finished (from client to server and back)

**Hello messages**
A. client: client version, client random (current time 4 bytes, and some random bytes 28 bytes), session id, cipher suites, compression methods
B. server: server version, server random (must be independent of the client), session id, cipher suite, compression method

You can force the server to use the least secure algorithms for compression and for cipher_suites. Vulnerability!

**Phase 2**
Supported key exchange methods:
- RSA Based: the secret key is encrypted with the server's public RSA
- static Diffie-Hellman: 
- ephemeral Diffie-Hellman

## SSH

Secure shell
Provides security at Application layer
Current version is SSH-2
BUilt on top of TCP
We have 3 layers:
1. SSH Transport Layer Protocol: initial connection, server auth, secure channel between client and server
2. SSH Authentication Protocol: client auth over secure transport channel
3. SSH Connection protocol: supports multiple connections over a single transport layer protocol secure channel, efficiency.

SSH-2 security goals:
 - server almost always authenticated
 - client almost always authenticated
 - establishment of a fresh, shared secret
 - secure ciphersuite negotiation

 It uses DH key exchange
SSH can do port forwarding. IF yo do not do this for every connection you need a separate set of keys.
Essentially you have one secure connection to a login server (the SSH server).
SSH can also do file transfers, and remote administration

**Analysis IPSec, SSL/TLS, SSH**
All have initial key establishment then key derivation (IKE in IPSec, Handshake in SSL/TLS, Authentication in SSH)
All protect ciphersuite negotiation
All use keys established to build a secure channel.
Operate at different network layers
All practical, but not simple. 
Security of all three udermined by: implementation weaknesses, weak server platform security, weak user platform security, limited deployment of certificates, lack of user awareness and education


### Kerberos
Old protocol
It is used for SSO.
It has an authentication server aka KDC (Key Distribution Center) which stores passwords. This server is a single point of failure. 
It is not built to work over the internet.
It provides Authentication, integrity, confidentiality, authorization.
The credentials are in the form of tickets (a set of bytes which contain the id of the client, a key, and a validity time for the ticket). I.e K{"alice", K(ab), lifetime}

An authenticator proves that the user presenting the ticket is the user the ticket was issued to. It also prevents replay attacks.
Ticket Granting Service (TGS) = a service that allows a auser to obtain tickets. In the same place as the KDC
Ticket Granting Ticket (TGT) = ticket used to access the TGS and obtain tickets. 
Limited-lifetime session key = TGS session key
TGT and TGS session-key cached on the user's workstation

*Crypto approach* - Symmetric encryption. Uses a third party

The biggest benefit of TGS is SSO capability. It also limits the exposure of a user's password.

Kerberos workflow:
1. request ticket for auth (and get TGT) - the server sends a ticket and a session key (only once)
2. request to TGS - server sends ticket and session key (one for every service)
3. send requests to server - server provides server authenticator

**1**
The client sends username, request for authentication. and current time
The server replies with a ticket encrypted with client's password (the server knows all users and passwords)

**2**
Here the server only know the TGTs (granted, expiration, keys)
Client send username, service request, current time. All encrypted with TG key
Server responds with session key (encrypted with TG key), and ticket for requested service (encrypted with autehntication services (AS) key, this is only known by the server and all the invoked services)

**3**
Client sends ticket for requested service ecnrypted with AS key, and authenticator encrpyted with the session key.
