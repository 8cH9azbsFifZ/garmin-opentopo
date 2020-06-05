#!/bin/bash

test -d ||mkdir -p /garmin/fzk
#cp -rv /opt/fzk/Freizeitkarte-Entwicklung/* /garmin/fzk
rsync -avP /opt/fzk/Freizeitkarte-Entwicklung/. /garmin/fzk/.

/garmin/fzk/mt.pl bootstrap 

