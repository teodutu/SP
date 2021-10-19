#! /bin/bash

if [ $# != "3" ]; then
	echo "Usage: $0 <dir> <name> <config>"
	exit 1
fi

DIR=$1
NAME=$2
CFG=$3

# Revoke cert
openssl ca -revoke $DIR/$NAME.crt -config $CFG

# Generate new crl
openssl ca -gencrl -out $DIR/crl.pem -config $CFG
