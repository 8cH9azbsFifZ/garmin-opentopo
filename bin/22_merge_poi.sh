#!/bin/bash

poi_gpx=install/RLP-0.3.1.gpx # source file
poi_osm=work/Freizeitkarte_RHEINLAND-PFALZ/RLP.osm #tmp file
poi_osm1=work/Freizeitkarte_RHEINLAND-PFALZ/RLP1.osm # tmp file
kartendaten=work/Freizeitkarte_RHEINLAND-PFALZ/Kartendaten_Freizeitkarte_RHEINLAND-PFALZ.osm.pbf #target file
kartendaten_orig=$kartendaten.orig
kartendaten1=work/Freizeitkarte_RHEINLAND-PFALZ/Kartendaten_Freizeitkarte_RHEINLAND-PFALZ1.osm.pbf #tmp
kartendaten2=work/Freizeitkarte_RHEINLAND-PFALZ/Kartendaten_Freizeitkarte_RHEINLAND-PFALZ2.osm.pbf #tmp

#gpsbabel -i gpx -f  install/RLP-0.3.1.gpx -o osm,tagnd="man_made:adit" -F work/Freizeitkarte_RHEINLAND-PFALZ/RLP.osm
gpsbabel -i gpx -f $poi_gpx  -o osm,tagnd="man_made:adit;disused:yes" -F $poi_osm

# gut
# 4267112252
# 246749945

# nicht gut?
# 10134671122

#cp $kartendaten $kartendaten_orig # FIXME


offset=2
cat $poi_osm|awk -v rnd=$offset -F="' " '/node id/{l=$0;gsub("  <node id=","");m=$0;gsub(" .*","");n=$0;gsub("'\''","");a=++rnd;f="  <node id='\''"a"'\''"m;gsub("'\'\''-","",f);print f}/</{print}'>$poi_osm1
#cat work/Freizeitkarte_RHEINLAND-PFALZ/RLP.osm|awk -v rnd=$offset -F="' " '/node id/{l=$0;gsub("  <node id=","");m=$0;gsub(" .*","");n=$0;gsub("'\''","");a=$0*-1+rnd;f="  <node id='\''"a"'\''"m;gsub("'\'\''-","",f);print f}/</{print}'>work/Freizeitkarte_RHEINLAND-PFALZ/RLP1.osm
osmconvert $poi_osm1 -o=$poi_osm1.pbf

# manual stull cf. rlp1. bounds, timestamp, generator
osmconvert $poi_osm1.pbf|sed 's/changeset="1"/changeset="0"/g' >RLP2.osm
sh /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung/tools/osmosis/bin/osmosis  --read-pbf /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung/work/Freizeitkarte_RHEINLAND-PFALZ/Kartendaten_Freizeitkarte_RHEINLAND-PFALZ.osm.pbf --read-pbf $poi_osm1.pbf  --merge --write-pbf /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung/work/Freizeitkarte_RHEINLAND-PFALZ/Freizeitkarte_RHEINLAND-PFALZ.osm.pbf omitmetadata=true



# cf. https://wiki.openstreetmap.org/wiki/Import/Software#Negative_IDs

###osmconvert $kartendaten_orig $poi_osm1.pbf -o=$kartendaten1
###osmconvert $kartendaten1 |sed 's/changeset="1"/changeset="0"/g' > $kartendaten2
###osmconvert $kartendaten2 -o=$kartendaten

# osmconvert $kartendaten |grep -A4 -B4 "Grube Dorweiler"
#https://www.google.de/maps/place/50%C2%B008'29.7%22N+7%C2%B026'26.8%22E/@50.1409961,7.4384441,16.33z/data=!4m5!3m4!1s0x0:0x0!8m2!3d50.141582!4d7.440785


#Ausoniusstollen: 
# https://www.google.de/maps/place/50%C2%B015'44.6%22N+7%C2%B026'23.5%22E/@50.2624004,7.4376793,17z/data=!3m1!4b1!4m5!3m4!1s0x0:0x0!8m2!3d50.262397!4d7.439868
# https://opentopomap.org/#map=17/50.26120/7.43946
# osmconvert $kartendaten |grep -A4 -B4 "Ausoniusstollen"

./mt.pl join $region

#sh /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung/tools/osmosis/bin/osmosis --read-pbf $poi_osm1.pbf --read-pbf /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung/work/Freizeitkarte_RHEINLAND-PFALZ/Kartendaten_Freizeitkarte_RHEINLAND-PFALZ.osm.pbf --read-pbf /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung/work/Freizeitkarte_RHEINLAND-PFALZ/Hoehendaten_Freizeitkarte_RHEINLAND-PFALZ.osm.pbf --merge --write-pbf /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung/work/Freizeitkarte_RHEINLAND-PFALZ/Freizeitkarte_RHEINLAND-PFALZ.osm.pbf omitmetadata=true


./mt.pl split $region