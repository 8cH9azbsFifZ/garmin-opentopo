#!/bin/bash

# Prepare Typ Files
echo "create typfiles if neccessary"
fid=$(./mt.pl -? |grep $region|cut -d " " -f 1)
find work/typfiles/$lang/freizeit.TYP ||./mt.pl alltypfiles

# OpenTopoMap - Cave
echo Create Opentopo cave typ
java -jar ./tools/mkgmap/mkgmap.jar --family-id=$fid ./TYP/OpenTopoMap-Cave.txt
mv OpenTopoMap-Cave.typ TYP

# OpenTopoMap
echo Create Opentopo typ
java -jar ./tools/mkgmap/mkgmap.jar --family-id=$fid ./TYP/OpenTopoMap.txt 
mv OpenTopoMap.typ TYP

# Fenix 6x typ
echo Create Fenix 6x typ
java -jar ./tools/mkgmap/mkgmap.jar --family-id=$fid ./TYP/fenix-6x.txt 
mv fenix-6x.typ TYP