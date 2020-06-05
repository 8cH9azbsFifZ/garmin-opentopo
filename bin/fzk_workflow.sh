#!/bin/bash

#FIXME
cd /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung/

./mt.pl create $region
find work/$region/Kartendaten*pbf ||./mt.pl fetch_osm $region

find work/$region/Hoehendaten*pbf ||./mt.pl fetch_ele $region

find work/$region/Freizeitkarte*pbf ||./mt.pl join $region

./mt.pl split $region


bootstrap  =     Complete the Environment with needed downloads (boundaries)
create     = 1.  (re)create all directories
fetch_osm  = 2a. fetch osm data from url
fetch_ele  = 2b. fetch elevation data from url
join       = 3.  join osm and elevation data
split      = 4.  split map data into tiles
build      = 5.  build map files (img, mdx, tdb)
gmap       = 6.  create gmap file (for BaseCamp OS X, Windows)
nsis       = 6.  create nsis installer (full installer for Windows)
gmapsupp   = 6.  create gmapsupp image (for GPS receiver)
imagedir   = 6.  create image directory (e.g. for QLandkarte)
