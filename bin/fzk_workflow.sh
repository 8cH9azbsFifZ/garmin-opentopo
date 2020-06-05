#!/bin/bash

region=Freizeitkarte_RHEINLAND-PFALZ
cd /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung/

./mt.pl create $region
find work/$region/Kartendaten*pbf ||./mt.pl fetch_osm $region

find work/$region/Hoehendaten*pbf ||./mt.pl fetch_ele $region

./mt.pl join $region