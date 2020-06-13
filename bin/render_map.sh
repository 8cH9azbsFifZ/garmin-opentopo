#!/bin/bash

#FIXME
cd /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung/

# Prepare Typ Files
echo "create typfiles if neccessary"
find work/typfiles/$lang/freizeit.TYP ||./mt.pl alltypfiles

# OpenTopo Map Style typ
echo Create Opentopo typ
fid=$(./mt.pl -? |grep $region|cut -d " " -f 1)
java -jar ./tools/mkgmap/mkgmap.jar --family-id=$fid ./TYP/OpenTopoMap.txt 
mv OpenTopoMap.typ TYP

# Fenix 6x typ
java -jar ./tools/mkgmap/mkgmap.jar --family-id=$fid ./TYP/fenix-6x.txt 
mv fenix-6x.typ TYP



# Remder the map
opts="--typfile=$PWD/TYP/$typ --style=$style" #default
echo "build      = 5.  build map files (img, mdx, tdb)"
./mt.pl $opts build $region 

echo "gmap       = 6.  create gmap file (for BaseCamp OS X, Windows)"
./mt.pl $opts gmap $region

#echo nsis       = 6.  create nsis installer (full installer for Windows)
# FIXME: UTF8 Problem

echo "gmapsupp   = 6.  create gmapsupp image (for GPS receiver)"
./mt.pl $opts gmapsupp $region

# Copy map data
rsync -avP work/${region}_$lang/$region.gmap install/

#echo imagedir   = 6.  create image directory (e.g. for QLandkarte)

