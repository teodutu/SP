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

# Revoke cert
openssl ca -revoke $DIR/$NAME -config $CFG

# Generate new crl
openssl ca -gencrl -out $DIR/crl.pem -config $CFG

# Test revocation. First concatenate ca cert with newly generated crl and then verify the revocation
cat $CA $DIR/crl.pem > $DIR/revoke.pem
openssl verify -CAfile $DIR/revoke.pem -crl_check $1

# Delete temporary test file
rm -f keys/revoke_test_file.pem
