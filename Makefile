# WIP - not yet working - but would be nice ;)
MKGMAP=mkgmap-r4193
SPLITTER=splitter-r591
MAPS_DIR=./maps
MAPS = $(MAPS_DIR)/hessen1-latest.img
STYLEFILE = ./style/opentopomap
TYPFILE = ./style/typ/OpenTopoMap.typ
MKGMAPJAR=./bin/tools/$(MKGMAP)/mkgmap.jar
OPTIONS=./style/opentopomap_options
SEA=./var/sea
BOUNDS=./var/bounds
DATA=./var/data/*.pbf
DOWNLOAD=./var/download

all: $(MAPS)

$(DOWNLOAD)/bounds.zip:
	wget -O $(DOWNLOAD)/bounds.zip http://osm2.pleiades.uni-wuppertal.de/bounds/latest/bounds.zip

$(BOUNDS)/germany.poly: $(DOWNLOAD)/bounds.zip
	unzip $(PWD)/$(DOWNLOAD)/bounds.zip -d  $(BOUNDS)
	# fix, such that extracted files are newer than archive (hack)
	find $(BOUNDS) -type f -exec touch {} \;

%.typ: %.txt
	java -jar $(MKGMAPJAR) --family-id=35 --output-dir=$(STYLEFILE) $<

%.img: $(STYLEFILE) $(TYPFILE) $(BOUNDS)/germany.poly
	mm="-Xmx1536M"
	echo java $(mm) -jar $(MKGMAPJAR) -c $(OPTIONS) --style-file=$(STYLEFILE) \
    --precomp-sea=$(SEA) \
    --output-dir=output --bounds=$(BOUNDS) $(DATA) $(TYPFILE)

