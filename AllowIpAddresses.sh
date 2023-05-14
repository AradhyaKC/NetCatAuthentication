#!/bin/bash
#sudo iptables-legacy -A INPUT -s 127.0.0.1 -p tcp  --dport 1234 -j ACCEPT
if [ -z "$1" ]; then 
echo no new ip address was added
else
echo $1 >> /netcatServer/allowedIpAddress.txt
fi

command=$(sudo iptables-legacy -F)

ip_count=$(awk 'END {print NR}' allowedIpAddress.txt)

for i in $(seq 1 $ip_count)
do
    ip_address=$(awk  -v myNum=$i 'NR==myNum {print}' /netcatServer/allowedIpAddress.txt)
    iptable_command=$(sudo iptables-legacy -A INPUT -s $ip_address -p tcp  --dport 1234 -j ACCEPT)
    # echo $iptable_command
done

reject_command=$(sudo iptables-legacy -A INPUT -p tcp --dport 1234 -j REJECT)
echo $reject_command