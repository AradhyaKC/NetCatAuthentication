#!/bin/bash

command=$(awk -v user=$1 -F: '$1==user' netcatUsers.txt)
password=$(echo $command |awk -F: '{print $2}')

if [ $password -eq $2 ]; then
    echo "success"
else
    echo "password is wrong"
fi