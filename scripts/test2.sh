#!/bin/bash
cd /usr/firmware/firmware_file
echo -n "input the firmware file's name:"
read name
echo -n "input the firmware file's path:"
read path
sudo cp $path/$name $name

sudo binwalk -eM $name
cd ../firmwalker
sudo bash firmwalker.sh /usr/firmware/firmware_file/_$name.extracted
cat firmwalker.txt


quit=q
until [ "$inner" == "$quit" ]
do
cd /usr/firmware/firmware_file/_$name.extracted/
echo -n "input the file's path(without d/):"
read file_path
cd ./$file_path
echo -n "input the file's name:"
read file_name
cat $file_name
echo "(input q to quit,others to continue):"
read inner
done

exit 0




