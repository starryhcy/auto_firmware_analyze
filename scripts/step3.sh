#!/bin/bash
cd /usr/firmware/firmadyne

echo -n "input the firmware file's name:"
read name
echo -n "input the firmware file's path:"
read path
sudo cp $path/$name $name

sudo python fat.py $name



