#!/bin/bash

# Prepare Typ Files
echo "create typfiles if neccessary"
fid=$(./mt.pl -? |grep $region|cut -d " " -f 1)
find work/typfiles/$lang/freizeit.TYP ||./mt.pl alltypfiles

# OpenTopoMap - Cave
echo Create Opentopo cave typ
fn=OpenTopoMap-Cave
test -e TYP/$fn.typ ||(java -jar ./tools/mkgmap/mkgmap.jar --family-id=$fid ./TYP/$fn.txt && mv $fn.typ TYP)

# OpenTopoMap
echo Create Opentopo typ
fn=OpenTopoMap
test -e TYP/$fn.typ ||(java -jar ./tools/mkgmap/mkgmap.jar --family-id=$fid ./TYP/$fn.txt && mv $fn.typ TYP)

# Fenix 6x typ
echo Create Fenix 6x typ
fn=fenix-6x
test -e TYP/$fn.typ ||(java -jar ./tools/mkgmap/mkgmap.jar --family-id=$fid ./TYP/$fn.txt && mv $fn.typ TYP)
