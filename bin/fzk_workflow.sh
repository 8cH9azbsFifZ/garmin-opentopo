#!/bin/bash

#FIXME
cd /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung/

echo bootstrap  =     Complete the Environment with needed downloads (boundaries)

echo create     = 1.  (re)create all directories
./mt.pl create $region

echo fetch_osm  = 2a. fetch osm data from url
find work/$region/Kartendaten*pbf ||./mt.pl fetch_osm $region

echo fetch_ele  = 2b. fetch elevation data from url
find work/$region/Hoehendaten*pbf ||./mt.pl fetch_ele $region

echo join       = 3.  join osm and elevation data
find work/$region/Freizeitkarte*pbf ||./mt.pl join $region

echo split      = 4.  split map data into tiles
find work/$region/*.osm.gz ||./mt.pl split $region

echo build      = 5.  build map files (img, mdx, tdb)
find work/${region}_$lang/ -name *.img ||./mt.pl build $region 

echo gmap       = 6.  create gmap file (for BaseCamp OS X, Windows)
find work/${region}_$lang/ -name *.gmap ||./mt.pl gmap $region

#echo nsis       = 6.  create nsis installer (full installer for Windows)
# FIXME: UTF8 Problem

echo gmapsupp   = 6.  create gmapsupp image (for GPS receiver)
find work/${region}_$lang/$region.gmap ||./mt.pl gmapsupp $region

#echo imagedir   = 6.  create image directory (e.g. for QLandkarte)
