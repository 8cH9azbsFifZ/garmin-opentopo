# Building Garmin Maps from OSM data.

*Status*: WIP...

## Features
- Self contained docker image for rendering osm maps for garmin devices.
- Support for various styles: OpenTopoMap, Freizeitkarte, Fenix 6.
- Support for custom POI overlays (i.e. caves).

![Example map](doc/example.png)

# Installation
- Requirements: at least 2 GB memory, at least 5 GB hdd storage
- Runtime: germany Total time taken: 1 hour 48 minutes 3 seconds


## Running the tool

*Status*: WIP...

+ Build using: `make build``
+ Initialize using `docker-compose up``
+ Wait for initial setup to complete
+ Enter commandline and continue 


    docker-compose run mt bash
    /opt/garmin/bin/24_merge_elevation.sh
    /opt/garmin/bin/32_render_map.sh

### Running with custom POI files
TBD: adjust POI source file with environment variables

    /opt/garmin/bin/22_merge_poi.sh 
    /opt/garmin/bin/32_render_map.sh


## Howto adjust style
*Status*: WIP...

- Which points to show in which zoom level? style/opentopomap/points
- Icons in XPM style/typ/OpenTopoMap.typ


# Licenses
- This module: GPL
- Merged contents (cf. the references):
- (c) Map: FZK project (free for private use)
- Map data: OpenStreetMap contributors
- Contour data: U.S. Geological Survey or J. de Ferranti


# References
- OpenTopoMap style: [OpenTopoMap](https://github.com/der-stefan/OpenTopoMap) 
- Input for style definitions: [MKGMAP Hiking](https://github.com/vibrog/mkgmap-hiking) 
- [OSMCONVERT](http://m.m.i24.cc/osmconvert.c)
- [MKGMAP](http://www.mkgmap.org.uk/download/mkgmap.html) and its [SPLITTER](http://www.mkgmap.org.uk/download/splitter.html)
- [phyghtmap](http://katze.tfiu.de/projects/phyghtmap/)
- SRTM OSM data [Bike Extract SRTM OSM](https://extract.bbbike.org/)
- Freizeitkarte development environment [github](https://github.com/freizeitkarte/fzk-mde-garmin)
- Garmin Fenix 6 style files [github](https://github.com/ahotzler/garmin-fenix-6x-outdoor-typfile-AH)

