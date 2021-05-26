#!/bin/bash

senLoc=$1

echo "I am going to work on this location: ${senLoc}"

while true;
do
    read -p "Do you wish to process all the images?" yn
    case $yn in
        [Yy]* )
          for item in *;
          do
            # Create a mapset of the tile
            g.mapset -c mapset="${item}" location="${senLoc}";
            # Change to the mapset
            g.mapset mapset="${item}" location="${senLoc}";
            # Import tile to the mapset
            i.sentinel.import input="${item}" pattern='B(02_1|03_1|04_1|05_2|06_2|07_2|08_1|8A_2|11_2|12_2)0m';
            # Get First map
            g.list type=rast | grep -v / | tr '\n' ',' | awk  -F, '{print $1}' > ../region.txt;
            # Set region to the first map - If more than one tile is needed
            g.region raster=$(<../region.txt);
            # Get groups band name
            g.list type=rast | grep -v / | tr '\n' ',' > ../bands_name.txt;
            bands_name=$(<../bands_name.txt);
            # Group bands into a group
            i.group group="${item}" input="${bands_name}";
            # Export group
            r.out.gdal -c input="${item}" output="${item}".tif type=UInt16;
          done; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

exit
