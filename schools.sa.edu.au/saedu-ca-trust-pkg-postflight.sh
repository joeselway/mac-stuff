#!/bin/bash

echo 'Installing SAEDU Issuing CA'

mkdir /tmp/saedu-ca

curl -k -o "/tmp/saedu-ca/saedu-int-ca.cer" "http://ca.schools.sa.edu.au/SAEDUIssuingCA_SHA2.cer"

sudo /usr/bin/security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain /tmp/saedu-ca/saedu-int-ca.cer

rm -rf /tmp/saedu-ca

exit 0
