#!/bin/bash
# init
function pause(){
   read -p "$*"
}

if [ $# -ne 3 ]; then
 echo 'please provide login credentials of the cloudcenter artifact server'
 echo '1.[user name]'
 echo '2.[user password]'
 echo '3.[cc binary url]'
 exit 1
fi

USERNAME=$1
USERPASSWORD=$2
CC_BINARY_URL=$3

############### ANSIBLE ###################
source 00_ansible-cca.sh $USERNAME $USERPASSWORD $CC_BINARY_URL
source 01_ansible-cco.sh $USERNAME $USERPASSWORD $CC_BINARY_URL