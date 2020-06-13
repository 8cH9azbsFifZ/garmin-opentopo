#!/bin/bash


echo "join       = 3.  join osm and elevation data"
find work/$region/Freizeitkarte*pbf ||./mt.pl join $region

echo "split      = 4.  split map data into tiles"
find work/$region/*.osm.gz ||./mt.pl split $region
