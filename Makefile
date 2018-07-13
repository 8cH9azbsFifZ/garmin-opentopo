# WIP - not yet working - but would be nice ;)
MAPS = germany/hessen-latest 
all: $(MAPS_DIR)/hessen1-latest.img

MKGMAP=mkgmap-r4193
SPLITTER=splitter-r591

MAPS_DIR=./maps
STYLEFILE = ./style/opentopomap
TYPFILE = ./style/typ/OpenTopoMap.typ
MKGMAPJAR=./bin/tools/$(MKGMAP)/mkgmap.jar
OPTIONS=./style/opentopomap_options
SEA=./var/sea
BOUNDS=./var/bounds
DATA=./var/data/*.pbf
DOWNLOAD=./var/download
OUTPUT=./var/output



# Create a .TYP file 
%.typ: %.txt
	java -jar $(MKGMAPJAR) --family-id=35 --output-dir=$(STYLEFILE) $<

# Create an IMG Map file
%.img: $(STYLEFILE) $(TYPFILE) $(BOUNDS)/germany.poly $(SEA)/version.txt
	mm="-Xmx1536M" # Memory limitation
	echo java $(mm) -jar $(MKGMAPJAR) -c $(OPTIONS) --style-file=$(STYLEFILE) \
    --precomp-sea=$(SEA) \
    --output-dir=$(OUTPUT) --bounds=$(BOUNDS) $(DATA) $(TYPFILE)

# Download Boundaries
$(DOWNLOAD)/bounds.zip:
	wget -O $(DOWNLOAD)/bounds.zip http://osm2.pleiades.uni-wuppertal.de/bounds/latest/bounds.zip

# Download Sea
$(DOWNLOAD)/sea.zip:
	wget -O $(DOWNLOAD)/sea.zip http://osm2.pleiades.uni-wuppertal.de/sea/latest/sea.zip


# Unpack sea
$(SEA)/version.txt: $(DOWNLOAD)/sea.zip
	unzip $(PWD)/$(DOWNLOAD)/sea.zip -d  $(SEA)
	# fix, such that extracted files are newer than archive (hack)
	find $(SEA) -type f -exec touch {} \;

# Unpack boundaries
$(BOUNDS)/germany.poly: $(DOWNLOAD)/bounds.zip
	unzip $(PWD)/$(DOWNLOAD)/bounds.zip -d  $(BOUNDS)
	# fix, such that extracted files are newer than archive (hack)
	find $(BOUNDS) -type f -exec touch {} \;

