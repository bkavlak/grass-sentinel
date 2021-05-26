#!/bin/bash

echo "This script is for creating sentinel folders for tiles"
echo "I'm working!"

echo "If you are really willing to run me, you'll move all"
echo "the '.zip' files to defined folder. Then I'll create folders"
echo "named as the same as the '.zip' file, of course, without"
echo "the '.zip' part. I'll then move the '.zip's to the folders"

echo "You'll then be able to run 'sen2Process.sh' to preprocess"
echo "Sentinel-2 tiles."

senDir=$1

echo "My destination folder is ${senDir}"

while true;
do
    read -p "Are you sure to move all the zips?" yn
    case $yn in
        [Yy]* )
          for file in *.zip
          do
            dir="${file%.zip}";
            mkdir -- "${senDir}/${dir}";
            chmod a+rwx "${senDir}/${dir}";
            mv "${file}" "${senDir}/${dir}";
            done; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

exit
