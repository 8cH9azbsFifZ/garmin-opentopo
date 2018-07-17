# WIP - not yet working - but would be nice ;)
MAPS = hessen rheinland-pfalz

MKGMAP=mkgmap-r4193
SPLITTER=splitter-r591
PHYGHTMAP=phyghtmap-2.20

MAPS_DIR=./maps
STYLEFILE = ./style/opentopomap
TYPFILE = ./style/typ/OpenTopoMap.typ
TOOLS_DIR=./bin/tools
MKGMAPJAR=$(TOOLS_DIR)/$(MKGMAP)/mkgmap.jar
SPLITTERJAR=$(TOOLS_DIR)/${SPLITTER}/splitter.jar
OSMCONVERT=$(TOOLS_DIR)/osmconvert/osmconvert
PHYGHTMAP_DIR=$(TOOLS_DIR)/$(PHYGHTMAP)

OPTIONS=./style/opentopomap_options
SEA=./var/sea
BOUNDS=./var/bounds
DATA_DIR=./var/data
DOWNLOAD=./var/download
OUTPUT=./var/output
POI_DIR=./var/poi

# Download 
$(PHYGHTMAP_DIR)/setup.py:
#	echo "Download new " $@
#	wget -O $(DOWNLOAD) http://katze.tfiu.de/projects/phyghtmap/phyghtmap_2.20.orig.tar.gz

# Build OSM convert
$(OSMCONVERT): $(OSMCONVERT).c
	gcc $< -lz -O3 -o $@

# Convert .GPX to .OSM
$(POI_DIR)/%.osm: $(POI_DIR)/%.gpx $(OSMCONVERT)
	#FIXME: more than old mines?
	gpsbabel -i gpx -f $< -o osm,tagnd="man_made:adit" -F $@
#../bin/osmconvert/osmconvert ../data/test_poi.osm ../data/test_map.osm -o=complete.osm


# Create a .TYP file 
%.typ: %.txt
	java -jar $(MKGMAPJAR) --family-id=35 --output-dir=$(STYLEFILE) $<

# Download Boundaries
$(DOWNLOAD)/bounds.zip:
	echo "Obtaining new file " $<
	wget -O $(DOWNLOAD)/bounds.zip http://osm2.pleiades.uni-wuppertal.de/bounds/latest/bounds.zip

# Download Sea
$(DOWNLOAD)/sea.zip:
	echo "Obtaining new file " $<
	wget -O $(DOWNLOAD)/sea.zip http://osm2.pleiades.uni-wuppertal.de/sea/latest/sea.zip

# Unpack sea
$(SEA)/version.txt: $(DOWNLOAD)/sea.zip
	echo "Unzip " $<
	unzip $(PWD)/$(DOWNLOAD)/sea.zip -d  $(SEA)
	# fix, such that extracted files are newer than archive (hack)
	find $(SEA) -type f -exec touch {} \;

# Unpack boundaries
$(BOUNDS)/version.txt: $(DOWNLOAD)/bounds.zip
	echo "Unzip " $<
	unzip $(PWD)/$(DOWNLOAD)/bounds.zip -d  $(BOUNDS)
	# fix, such that extracted files are newer than archive (hack)
	find $(BOUNDS) -type f -exec touch {} \;

$(BOUNDS)/europe.poly:
	echo "Download new " $@
	wget -O $@ http://download.geofabrik.de/europe.poly

# Download latest OSM data
COUNTRY=europe/germany
$(DOWNLOAD)/%.osm.pbf.md5: 
	echo "Obtaining new MD5 OSM data file " $@
#	wget -O $@ https://download.geofabrik.de/$(COUNTRY)/$(notdir $@)
#FIXME: rm temp files???

$(DOWNLOAD)/%.osm.pbf: $(DOWNLOAD)/%.osm.pbf.md5 
	echo "Obtaining new OSM data file " $@
	#TODO md5 $FNAME.osm.pbf | grep $(cut -f 1 -d " " $FNAME.osm.pbf.md5 )  -> or download
#	wget -O $@ https://download.geofabrik.de/$(COUNTRY)/$(notdir $@)


# Split files 
$(DATA_DIR)/%/63240001.osm.pbf: $(DOWNLOAD)/%.osm.pbf
	echo "Splitting " $<
	test -d $(dir $@) || mkdir $(dir $@)
	java -jar $(SPLITTERJAR) --precomp-sea=$(SEA) --output-dir=$(dir $@) $<

# Create an IMG Map file
$(MAPS_DIR)/%.img: $(DATA_DIR)/%/63240001.osm.pbf $(STYLEFILE) $(TYPFILE) $(BOUNDS)/version.txt $(SEA)/version.txt
	echo "Building new map IMG file " $@
	#mm="-Xmx1536M" # Memory limitation
	java -jar $(MKGMAPJAR) -c $(OPTIONS) --style-file=$(STYLEFILE) \
    --precomp-sea=$(SEA) \
    --output-dir=$(OUTPUT) --bounds=$(BOUNDS) $(dir $<)/*.pbf $(TYPFILE)

# Push file to android device
#adb push output/gmapsupp.img /mnt/sdcard/oruxmaps/mapfiles


all: $(MAPS_DIR)/hessen-latest.img

