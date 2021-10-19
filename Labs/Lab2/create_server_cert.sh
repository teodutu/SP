#! /bin/bash

if [ $# != "4" ]; then
	echo "Usage: $0 <dir> <server> <config> <CN>"
	exit 1
fi

DIR=$1
SERVER=$2
CFG=$3
SUBJ="/C=RO/ST=Bucharest/L=Bucharest/O=upb/OU=cti/CN=$4/emailAddress=a@b.com"

# Create server certificate request
openssl req -days 3650 -nodes -new -keyout $DIR/$SERVER.key -out $DIR/$SERVER.csr \
	-config $CFG -subj $SUBJ

# Sign the server certificate request using the previously generated CA
openssl ca -days 3650 -out $DIR/$SERVER.crt -in $DIR/$SERVER.csr -extensions server \
	-config $CFG

# Delete any .old files
rm -f keys/*.old
