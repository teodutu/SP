#! /bin/bash

if [ $# != "4" ]; then
	echo "Usage: $0 <dir> <client> <config> <CN>"
	exit 1
fi

DIR=$1
CLIENT=$2
CFG=$3
SUBJ="/C=RO/ST=Bucharest/L=Bucharest/O=upb/OU=cti/CN=$4/emailAddress=a@b.com"

# Create client certificate request
openssl req -days 3650 -nodes -new -keyout $DIR/$CLIENT.key -out $DIR/$CLIENT.csr \
	-config $CFG -subj $SUBJ

# Sign the client certificate request using the previously generated CA
openssl ca -days 3650 -out $DIR/$CLIENT.crt -in $DIR/$CLIENT.csr -config $CFG

# Delete any .old files
rm -f keys/*.old
