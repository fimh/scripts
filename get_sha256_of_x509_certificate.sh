#!/bin/bash
# calculate the sha256 hash of the given x509 certificate

# check input parameters
if [ $# -lt 1 ]
then
    echo "Usage: $0 [cert_file] "
    exit 1
fi

# input file
in=$1

# check whether it's der or pem encoded
der_magic_number="3082" # constant of der's magic number
magic_number=`xxd -ps -l 2 $in` # get the first 2 bytes of the input file
# is_der_encoded=`$der_magic_number==$magic_number`
# optional_param=$is_der_encoded?"-inform der":""
if [ $der_magic_number == $magic_number ]   # der encoded
then
    echo "file $in is der encoded"
    openssl x509 -inform der -in $in -pubkey -noout | openssl rsa -pubin -outform der | openssl dgst -sha256 -binary | openssl enc -base64
else
    echo "file $in is pem encoded"
    openssl x509 -in $in -pubkey -noout | openssl rsa -pubin -outform der | openssl dgst -sha256 -binary | openssl enc -base64
fi





