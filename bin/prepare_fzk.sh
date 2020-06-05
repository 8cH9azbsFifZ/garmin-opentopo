#!/bin/bash

rsync -avP /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung/. /garmin/.

cd /garmin/

./mt.pl bootstrap 

