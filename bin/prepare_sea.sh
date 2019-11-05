#!/bin/bash
DOWNLOAD=./var/download
SEAZIP=$DOWNLOAD/sea.zip

test -e $SEAZIP || wget -O $SEAZIP http://osm.thkukuk.de/data/sea-latest.zip
test -e ./var/sea/version.txt ||unzip $SEAZIP -d ./var
