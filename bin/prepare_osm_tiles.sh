#!/bin/bash

#FIXME
cd /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung/

echo "bootstrap  =     Complete the Environment with needed downloads (boundaries)"
#FIXME not used here

echo "create     = 1.  (re)create all directories"
test -d work/$region/||./mt.pl create $region
#FIXME: force option as environment




# Prepare map raw data
# FIXME: separate data from rendering ..
echo "fetch_osm  = 2a. fetch osm data from url"
find work/$region/Kartendaten*pbf ||./mt.pl fetch_osm $region

echo "fetch_ele  = 2b. fetch elevation data from url"
find work/$region/Hoehendaten*pbf ||./mt.pl fetch_ele $region

echo "join       = 3.  join osm and elevation data"
find work/$region/Freizeitkarte*pbf ||./mt.pl join $region

echo "split      = 4.  split map data into tiles"
find work/$region/*.osm.gz ||./mt.pl split $region


