#! /bin/bash

if [ $# != "4" ]; then
	echo "Usage: $0 <dir> <ca> <config> <CN>"
	exit 1
fi

DIR=$1
CA=$2
CFG=$3
SUBJ="/C=RO/ST=Bucharest/L=Bucharest/O=upb/OU=cti/CN=$4/emailAddress=a@b.com"

if ! [ -d $DIR ]; then
	mkdir $DIR;
fi

touch $DIR/index.txt
echo 01 > $DIR/serial

# Create CA key
openssl req -days 3650 -nodes -new -x509 -keyout $DIR/$CA.key -out $DIR/$CA.crt \
	-config $CFG -subj $SUBJ
