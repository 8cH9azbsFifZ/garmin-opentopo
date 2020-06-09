#!/bin/bash

#FIXME
cd /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung/



# Prepare Typ Files
echo "create typfiles if neccessary"
find work/typfiles/$lang/freizeit.TYP ||./mt.pl alltypfiles



# Remder the map
# --typfile=freizeit.TYP --style=fzk
opts="--typfile=freizeit.TYP --style=fzk" #default
echo "build      = 5.  build map files (img, mdx, tdb)"
./mt.pl $opts build $region 

echo "gmap       = 6.  create gmap file (for BaseCamp OS X, Windows)"
./mt.pl $opts gmap $region

#echo nsis       = 6.  create nsis installer (full installer for Windows)
# FIXME: UTF8 Problem

echo "gmapsupp   = 6.  create gmapsupp image (for GPS receiver)"
./mt.pl $opts gmapsupp $region

# Copy map data
rsync -avP work/${region}_$lang/$region.gmap install/$region.gmap

#echo imagedir   = 6.  create image directory (e.g. for QLandkarte)

