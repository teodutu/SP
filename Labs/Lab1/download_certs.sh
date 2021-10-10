#! /bin/bash

WEBSITES=("graphs.ro" "pornhub.com" "amuritioniliescu.ro")

for website in "${WEBSITES[@]}"; do
	echo $website
	openssl s_client -connect $website:443 -showcerts < /dev/null | openssl x509 -text > $website.crt
	echo ""
done
