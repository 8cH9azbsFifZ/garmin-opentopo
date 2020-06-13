#!/bin/bash
DOWNLOAD=/garmin/var/download
SEAZIP=$DOWNLOAD/sea.zip
BOUNDSZIP=$DOWNLOAD/bounds.zip

test -d $DOWNLOAD ||mkdir -p $DOWNLOAD

test -e $SEAZIP ||wget -O $SEAZIP http://osm.thkukuk.de/data/sea-latest.zip
test -e ./var/sea/version.txt ||unzip $SEAZIP -d ./var


test -e $BOUNDSZIP ||wget -O $BOUNDSZIP http://osm.thkukuk.de/data/bounds-latest.zip
test -e ./var/bounds/version.txt ||unzip $BOUNDSZIP -d ./var/bounds

