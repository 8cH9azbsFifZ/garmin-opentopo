#!/bin/bash
echo "bootstrap  =     Complete the Environment with needed downloads (boundaries)"
#FIXME not used here

test -e /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung/sea/version.txt ||./mt.pl bootstrap
test -e /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung/bounds/version.txt ||./mt.pl bootstrap

