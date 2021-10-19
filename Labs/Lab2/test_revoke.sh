#! /bin/bash

if [ $# != "3" ]; then
	echo "Usage: $0 <dir> <name> <CA>"
	exit 1
fi

DIR=$1
NAME=$2
CA=$3

# Test revocation. First concatenate ca cert with newly generated crl and then verify the revocation
cat $DIR/$CA.crt $DIR/crl.pem > $DIR/revoke.pem
openssl verify -CAfile $DIR/revoke.pem -crl_check $DIR/$NAME.crt

# Delete temporary test file
rm -f keys/revoke.pem
