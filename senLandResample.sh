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
            # Set image name
            echo "${item}" | sed s/"$*.tif"// > ../img_name.txt;
            img_name=$(<../img_name.txt);
            # Create a mapset of the tile
            g.mapset -c mapset="${img_name%.tif}" location="${senLoc}";
            # Change to the mapset
            g.mapset mapset="${img_name%.tif}" location="${senLoc}";
            # Import tile to the mapset
            r.import input="${item}" output="${img_name%.tif}";
            # Set Region to Map
            g.region raster="${img_name%.tif}".1;
            # Set Resolution to 5m
            g.region res=5;
            # Export group
            r.out.gdal -c input="${img_name%.tif}" output="${img_name%.tif}"_5m.tif type=UInt16;
          done; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

exit
