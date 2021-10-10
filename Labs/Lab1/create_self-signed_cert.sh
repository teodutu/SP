#! /bin/bash

CERT_NAME="putu"
KEY_NAME="key"

openssl genrsa -out $KEY_NAME.pem 4096
openssl req -new -sha256 -key $KEY_NAME.pem -out $CERT_NAME.pem \
	-subj "/C=RO/ST=Bucharest/L=Bucharest/O=Skoala Vetzi/OU=Kre o Are Toti Baetzi/CN=???/emailAddress=manelele.ie@vtm.com"
openssl x509 -req -days 365 -in $CERT_NAME.pem -signkey $KEY_NAME.pem -sha256 -out $CERT_NAME.crt
