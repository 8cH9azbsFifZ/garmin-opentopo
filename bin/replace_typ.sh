#!/bin/bash

typfile=./install/typfiles/de/outdoor.TYP 
imgfile=./install/Freizeitkarte_RHEINLAND-PFALZ_de/gmapsupp.img

#FIXME
cd /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung

gmt=./tools/ReplaceTyp/gmt

echo -n "Extracting Family ID: "
fid=`$gmt -i $imgfile | grep ", FID " | cut -d',' -f 2 | sed -e 's/ FID //'`

echo $fid

echo "Replacing Typ file..."
$gmt -w -y $fid $typfile
$gmt -w -x $typfile $imgfile


