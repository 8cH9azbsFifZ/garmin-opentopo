# WIP - not yet working - but would be nice ;)
MAPS = hessen rheinland-pfalz

MKGMAP=mkgmap-r4193
SPLITTER=splitter-r591

MAPS_DIR=./maps
STYLEFILE = ./style/opentopomap
TYPFILE = ./style/typ/OpenTopoMap.typ
MKGMAPJAR=./bin/tools/$(MKGMAP)/mkgmap.jar
SPLITTERJAR=./bin/tools/${SPLITTER}/splitter.jar

OPTIONS=./style/opentopomap_options
SEA=./var/sea
BOUNDS=./var/bounds
DATA_DIR=./var/data1
DOWNLOAD=./var/download
OUTPUT=./var/output





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
$(BOUNDS)/germany.poly: $(DOWNLOAD)/bounds.zip
	echo "Unzip " $<
	unzip $(PWD)/$(DOWNLOAD)/bounds.zip -d  $(BOUNDS)
	# fix, such that extracted files are newer than archive (hack)
	find $(BOUNDS) -type f -exec touch {} \;

# Download latest OSM data
COUNTRY=europe/germany
$(DOWNLOAD)/%.osm.pbf.md5: 
	echo "Obtaining new MD5 OSM data file " $@
	wget -O $@ https://download.geofabrik.de/$(COUNTRY)/$(notdir $@)

$(DOWNLOAD)/%.osm.pbf: $(DOWNLOAD)/%.osm.pbf.md5 
	echo "Obtaining new OSM data file " $@
	#TODO md5 $FNAME.osm.pbf | grep $(cut -f 1 -d " " $FNAME.osm.pbf.md5 )  -> or download
	echo wget -O $@ https://download.geofabrik.de/$(COUNTRY)/$(notdir $@)


# Split files 
# FIXME: Dir
$(DATA_DIR)/%.pbf: $(DOWNLOAD)/hessen-latest.osm.pbf
	echo "Splitting " $<
	java -jar $(SPLITTERJAR) --precomp-sea=$(SEA) --output-dir=$(DATA_DIR) $<
#TODO: sort per map

DATA=$(DATA_DIR)/*.pbf


# Create an IMG Map file
$(MAPS_DIR)/%.img: $(DOWNLOAD)/%.osm.pbf  $(STYLEFILE) $(TYPFILE) $(BOUNDS)/germany.poly $(SEA)/version.txt
	echo "Building new map IMG file " $<
	mm="-Xmx1536M" # Memory limitation
	echo java $(mm) -jar $(MKGMAPJAR) -c $(OPTIONS) --style-file=$(STYLEFILE) \
    --precomp-sea=$(SEA) \
    --output-dir=$(OUTPUT) --bounds=$(BOUNDS) $(DATA) $(TYPFILE)

# Push file to android device
#adb push output/gmapsupp.img /mnt/sdcard/oruxmaps/mapfiles


all: $(MAPS_DIR)/hessen-latest.img

