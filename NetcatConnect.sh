#!/bin/bash

echo enter username
read username

echo Enter password 
read password

doCurl=$(curl --http0.9 -X POST -d "username=$username&password=$password" http://localhost:8000)
response=$(echo $doCurl | awk '/success/ {print}')


if [ "$response" = "success" ]; then
    echo working
else
    echo failed auth
fi