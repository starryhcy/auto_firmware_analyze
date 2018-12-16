#!/bin/bash
sudo rm /var/cache/apt/archives/lock 
sudo rm /var/lib/dpkg/lock
 
cd /usr/firmware
sudo git clone https://github.com/devttys0/binwalk.git
cd binwalk

#若发生错误：E: 无法获得锁 /var/lib/dpkg/lock - open
#sudo rm /var/cache/apt/archives/lock  
#sudo rm /var/lib/dpkg/lock  

#Install Binwalk
sudo  ./deps.sh
sudo python ./setup.py install
sudo apt-get install python-lzma  
sudo -H pip install git+https://github.com/ahupp/python-magic

#Setting up firmadyne
cd ..
sudo apt-get  install busybox-static fakeroot git kpartx netcat-openbsd nmap python-psycopg2 python3-psycopg2 snmp uml-utilities util-linux vlan qemu-system-arm qemu-system-mips qemu-system-x86 qemu-utils
sudo git clone --recursive https://github.com/firmadyne/firmadyne.git
cd ./firmadyne; sudo ./download.sh
sudo cp firmadyne.config firmadyne.config.bak
sudo sed '4c FIRMWARE_DIR=/usr/firmware/firmadyne' firmadyne.config.bak | sudo tee firmadyne.config

#Setting up the database
cd ..
sudo apt-get -y install postgresql
sudo -u postgres createuser -P firmadyne	#with password: firmadyne
sudo -u postgres createdb -O firmadyne firmware
sudo -u postgres psql -d firmware < ./firmadyne/database/schema

#Setting up Firmware Analysis Toolkit (FAT)
#First install pexpect
pip install pexpect

sudo git clone https://github.com/attify/firmware-analysis-toolkit
sudo mv firmware-analysis-toolkit/fat.py .
sudo mv firmware-analysis-toolkit/reset.py .
sudo chmod +x fat.py 
sudo chmod +x reset.py

sudo cp fat.py fat.py.bak
sudo sed '11c firmadyne_path = "/usr/firmware/firmadyne"' fat.py.bak | sudo tee fat.py

#Setting up Firmware-mod-Kit
sudo apt-get -y install git build-essential zlib1g-dev liblzma-dev python-magic
sudo git clone https://github.com/brianpow/firmware-mod-kit.git

#Setting up MITMProxy
sudo apt-get -y install mitmproxy

#Setting up Firmwalker
sudo git clone https://github.com/craigz28/firmwalker.git
cd firmadyne
sudo cp ../fat.py fat.py
sudo cp ../reset.py reset.py

#sudo cp /home/hcy/DIR-300_REVA_FIRMWARE_1.06B05_WW.zip DIR-300_REVA_FIRMWARE_1.06B05_WW.zip
#sudo cp /home/hcy/WNAP320_V2.0.3_firmware.zip WNAP320_V2.0.3_firmware.zip

