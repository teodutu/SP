#! /bin/bash

if [ $# != "5" ]; then
	echo "Usage: $0 <dir> <name> <CA> <config> <CN>"
	exit 1
fi

DIR=$1
NAME=$2
CA=$3
CFG=$4
SUBJ="/C=RO/ST=Bucharest/L=Bucharest/O=upb/OU=cti/CN=$5/emailAddress=a@b.com"

# Build a request for a client certificate
openssl req -days 3650 -nodes -new -keyout $DIR/$NAME.key -out $DIR/$NAME.csr \
	-subj $SUBJ -config $CFG

# Sign the cert request with our ca, creating a cert/key pair
openssl ca -days 3650 -out $DIR/$NAME.crt -in $DIR/$NAME.csr -config $CFG

# Convert the key/cert and embed the ca cert into a pkcs12 file
openssl pkcs12 -export -inkey $DIR/$NAME.key -in $DIR/$NAME.crt \
	-certfile $DIR/$CA.crt -out $DIR/$NAME.p12

# Delete any .old files created in this process
rm -f $DIR/*.old
