#!/bin/bash

cd /usr/firmware/firmadyne
echo -n "input the ip:"
read IP
sudo bash ./analyses/snmpwalk.sh $IP
sudo python ./analyses/webAccess.py $IP log.txt
sudo nmap -O -sV $IP
sudo nmap --script=vuln -O -sV $IP

chmod +x analyses/*.py
sudo mkdir exploits
sudo python ./analyses/runExploits.py -t $IP -o exploits/exploit -e x
cd exploits
grep -rn html *