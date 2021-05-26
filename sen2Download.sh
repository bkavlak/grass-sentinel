#!/bin/bash

echo "This script is for downloading sentinel tiles"
echo "Using uuid list from a csv file"
echo "I'm working!"

repoDir=$1
uuidList=$2

echo "My destination folder is ${repoDir}"

while true;
do
    read -p "Are you sure to move all the zips?" yn
    case $yn in
        [Yy]* )
	while IFS=, read -r f1;
	do
    	    i.sentinel.download settings=credentials.txt uuid="${f1}" output="${repoDir}";
        done < "${uuidList}"; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

exit
