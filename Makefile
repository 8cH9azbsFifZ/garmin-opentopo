# do not remove tmp files
.SECONDARY:

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
OSMCONVERT=osmconvert
PHYGHTMAP_DIR=$(TOOLS_DIR)/$(PHYGHTMAP)
PHYGHTMAP=phyghtmap
SRTM_DIR=./var/srtm
HGT_DIR=$(SRTM_DIR)/hgt

OPTIONS=./style/opentopomap_options
SEA=./var/sea
BOUNDS=./var/bounds
#FIXME: rename to dir
DATA_DIR=./var/data
DOWNLOAD=./var/download
OUTPUT=./var/output
POI_DIR=./var/poi
POIFILE=$(POI_DIR)/poi.osm

# Convert POI file
# TODO: - Colored Input - for differnt pois...
$(POI_DIR)/%.osm: $(POI_DIR)/%.gpx
	#FIXME: more than old mines?
	gpsbabel -i gpx -f $< -o osm,tagnd="man_made:adit" -F $@

# Create a .TYP file 
# Default file already included
$(TYPFILE): ./style/typ/OpenTopoMap.txt
	java -jar $(MKGMAPJAR) --family-id=35 --output-dir=./style/typ $<

# Download Boundary Polygons
COUNTRY=europe/germany
#FIXME: country stuff in variable?

#wget http://download.geofabrik.de/europe/germany/hessen.poly
$(BOUNDS)/%.poly:
	echo "Download new " $@
	wget -O $@ http://download.geofabrik.de/$(COUNTRY)/$(notdir $@)

# Force a rebuild
FORCE:

# Download latest OSM data
#  wget https://download.geofabrik.de/europe/germany/hessen-latest.osm.pbf.md5
$(DOWNLOAD)/%-latest.osm.pbf.md5: FORCE
	echo "Obtaining new MD5 OSM data file " $@
	wget -O $@ https://download.geofabrik.de/$(COUNTRY)/$(notdir $@)

#  wget https://download.geofabrik.de/europe/germany/hessen-latest.osm.pbf
$(DOWNLOAD)/%-latest.osm.pbf: $(DOWNLOAD)/%-latest.osm.pbf.md5 $(POIFILE)
	echo "Obtaining new OSM data file " $@
	#FIXME: download only if needed 
	# -- md5 $@ | grep $(shell cut -f 1 -d " " $< ) && 
	echo wget -O $@ https://download.geofabrik.de/$(COUNTRY)/$(notdir $@)
	#FIXME: patch only if unpatched yet ..
	echo mv $@ $@.orig
	#Run with - in order to ignore the weird error codes returned...
	-$(OSMCONVERT) $(POIFILE) $@.orig -o=$@

# Split OSM files 
$(DATA_DIR)/%/63240001.osm.pbf: $(DOWNLOAD)/%-latest.osm.pbf 
	echo "Splitting " $<
	test -d $(dir $@) || mkdir $(dir $@)
	java -jar $(SPLITTERJAR) --precomp-sea=$(SEA) --output-dir=$(dir $@) $<

# Create SRTM OSM
$(SRTM_DIR)/%.osm.pbf: $(BOUNDS)/%.poly
	$(PHYGHTMAP) --output-prefix=$(SRTM_DIR)/$(notdir $@) --hgtdir=$(HGT_DIR) --polygon=$< -j 2 -s 10 -0 --source=view3 --max-nodes-per-tile=0 --max-nodes-per-way=0 --pbf
	mv $(SRTM_DIR)/$(notdir $@)*.osm.pbf $@

# Split the SRTM OSM files
$(DATA_DIR)/%/00003535.osm.pbf: $(SRTM_DIR)/%.osm.pbf 
	echo "Splitting " $<
	test -d $(dir $@) || mkdir $(dir $@)
	java -jar $(SPLITTERJAR) --mapid=3535 --output-dir=$(dir $@) $<

# Create an IMG Map file
# FIXME: magic numbers
$(MAPS_DIR)/%.img: $(DATA_DIR)/%/63240001.osm.pbf $(STYLEFILE) $(TYPFILE) $(BOUNDS)/version.txt $(SEA)/version.txt $(DATA_DIR)/%/00003535.osm.pbf
	echo "Building new map IMG file " $@
	#mm="-Xmx1536M" # Memory limitation
	java -jar $(MKGMAPJAR) -c $(OPTIONS) --style-file=$(STYLEFILE) \
    --precomp-sea=$(SEA) \
    --output-dir=$(OUTPUT) --bounds=$(BOUNDS) $(dir $<)/*.pbf $(TYPFILE)
	mv $(OUTPUT)/gmapsupp.img $@

# Push file to android device
ORUXMAPS_DIR=/mnt/sdcard/oruxmaps/mapfiles

android: $(MAPS_DIR)/hessen-latest.img
#FIXME: with variables..
	adb push $< $(ORUXMAPS_DIR)


all: $(MAPS_DIR)/hessen-latest.img


clean:
	find $(BOUNDS) -type f -exec rm {} \;
	find $(SEA) -type f -exec rm {} \;
#FIXME: hgt
	


# wget -r -np -N http://geoweb.hft-stuttgart.de/SRTM/srtm_as_osm/
#https://wiki.openstreetmap.org/wiki/SRTM
