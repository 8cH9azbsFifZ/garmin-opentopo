# WIP - not yet working - but would be nice ;)
MKGMAP=mkgmap-r4193
SPLITTER=splitter-r591
MAPS_DIR=./maps
MAPS = $(MAPS_DIR)/hessen1-latest.img
STYLEFILE = ./style/opentopomap
TYPFILE = ./style/typ/OpenTopoMap.typ
MKGMAPJAR=./tools/$(MKGMAP)/mkgmap.jar
OPTIONS=./opentopomap_options
SEA=./sea
BOUNDS=./bounds
DATA=./data/*.pbf


all: $(MAPS)

%.typ: %.txt
	java -jar $(MKGMAPJAR) --family-id=35 --output-dir=$(STYLEFILE) $<

%.img: $(STYLEFILE) $(TYPFILE)
	mm="-Xmx1536M"
	java $(mm) -jar $(MKGMAPJAR) -c $(OPTIONS) --style-file=$(STYLEFILE) \
    --precomp-sea=$(SEA) \
    --output-dir=output --bounds=$(BOUNDS) $(DATA) $(TYPFILE)

