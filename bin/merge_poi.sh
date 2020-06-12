gpsbabel -i gpx -f  install/RLP-0.3.1.gpx -o osm,tagnd="man_made:adit" -F work/Freizeitkarte_RHEINLAND-PFALZ/RLP.osm
cp work/Freizeitkarte_RHEINLAND-PFALZ/Kartendaten_Freizeitkarte_RHEINLAND-PFALZ.osm.pbf work/Freizeitkarte_RHEINLAND-PFALZ/Kartendaten_Freizeitkarte_RHEINLAND-PFALZ.osm.pbf.orig
osmconvert work/Freizeitkarte_RHEINLAND-PFALZ/RLP1.osm -o=work/Freizeitkarte_RHEINLAND-PFALZ/RLP1.osm.pbf
cat work/Freizeitkarte_RHEINLAND-PFALZ/RLP.osm|awk -v rnd=1012345 -F="' " '/node id/{l=$0;gsub("  <node id=","");m=$0;gsub(" .*","");n=$0;gsub("'\''","");a=$0*-1+rnd;f="  <node id='\''"a"'\''"m;gsub("'\'\''-","",f);print f}/</{print}'>work/Freizeitkarte_RHEINLAND-PFALZ/RLP1.osm

# cf. https://wiki.openstreetmap.org/wiki/Import/Software#Negative_IDs

osmconvert work/Freizeitkarte_RHEINLAND-PFALZ/Kartendaten_Freizeitkarte_RHEINLAND-PFALZ.osm.pbf.orig work/Freizeitkarte_RHEINLAND-PFALZ/RLP1.osm -o=work/Freizeitkarte_RHEINLAND-PFALZ/Kartendaten_Freizeitkarte_RHEINLAND-PFALZ.osm.pbf


osmconvert work/Freizeitkarte_RHEINLAND-PFALZ/Kartendaten_Freizeitkarte_RHEINLAND-PFALZ.osm.pbf|grep "Grube Dorweiler"




./mt.pl split $region