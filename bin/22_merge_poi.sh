#!/bin/bash

poi_gpx=RLP-0.3.1.gpx # source file # FIXME
kartendaten=work/$region/Kartendaten_$region.osm.pbf #target file
hoehendaten=work/$region/Hoehendaten_$region.osm.pbf #target file
mergedfile=work/$region/$region.osm.pbf 

#cp $kartendaten $kartendaten_orig # FIXME

# Convert GPX POI to OSM
poi_osm=work/$region/${poi_gpx/.gpx/.osm} #tmp file
gpsbabel -i gpx -f poi/$poi_gpx  -o osm,tagnd="man_made:adit;disused:yes" -F $poi_osm

# Fix negative IDs in OSM
# cf. https://wiki.openstreetmap.org/wiki/Import/Software#Negative_IDs
poi_osm1=work/$region/${poi_gpx/.gpx/.1.osm} # tmp file
offset=2
cat $poi_osm|awk -v rnd=$offset -F="' " '/node id/{l=$0;gsub("  <node id=","");m=$0;gsub(" .*","");n=$0;gsub("'\''","");a=++rnd;f="  <node id='\''"a"'\''"m;gsub("'\'\''-","",f);print f}/</{print}' > $poi_osm1

# Convert to PBF format and correct changeset
poi_osm2=work/$region/${poi_gpx/.gpx/.2.osm} # tmp file
osmconvert $poi_osm1 -o=$poi_osm1.pbf

# manual stull cf. rlp1. bounds, timestamp, generator # FIXME : may go...
osmconvert $poi_osm1.pbf|sed 's/changeset="1"/changeset="0"/g' > $poi_osm2
osmconvert $poi_osm2 -o=$poi_osm2.pbf

# Merge POI with map data
kartendaten1=work/$region/Kartendaten_$region.1.osm.pbf #tmp
sh /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung/tools/osmosis/bin/osmosis  --read-pbf $kartendaten --read-pbf $poi_osm2.pbf  --merge --write-pbf $kartendaten1 omitmetadata=true

# Merge map with height data
sh /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung/tools/osmosis/bin/osmosis  --read-pbf $kartendaten1 --read-pbf $hoehendaten  --merge --write-pbf $mergedfile omitmetadata=true # FIXME

# osmconvert $kartendaten |grep -A4 -B4 "Grube Dorweiler"
#https://www.google.de/maps/place/50%C2%B008'29.7%22N+7%C2%B026'26.8%22E/@50.1409961,7.4384441,16.33z/data=!4m5!3m4!1s0x0:0x0!8m2!3d50.141582!4d7.440785


#Ausoniusstollen: 
# https://www.google.de/maps/place/50%C2%B015'44.6%22N+7%C2%B026'23.5%22E/@50.2624004,7.4376793,17z/data=!3m1!4b1!4m5!3m4!1s0x0:0x0!8m2!3d50.262397!4d7.439868
# https://opentopomap.org/#map=17/50.26120/7.43946
# osmconvert $kartendaten |grep -A4 -B4 "Ausoniusstollen"

#sh /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung/tools/osmosis/bin/osmosis --read-pbf $poi_osm1.pbf --read-pbf /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung/work/Freizeitkarte_RHEINLAND-PFALZ/Kartendaten_Freizeitkarte_RHEINLAND-PFALZ.osm.pbf --read-pbf /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung/work/Freizeitkarte_RHEINLAND-PFALZ/Hoehendaten_Freizeitkarte_RHEINLAND-PFALZ.osm.pbf --merge --write-pbf /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung/work/Freizeitkarte_RHEINLAND-PFALZ/Freizeitkarte_RHEINLAND-PFALZ.osm.pbf omitmetadata=true


./mt.pl split $region