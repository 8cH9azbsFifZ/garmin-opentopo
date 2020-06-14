# Building Garmin Maps from OSM data.

*Status*: WIP...

## Features
- Self contained docker image for rendering osm maps for garmin devices.
- Support for various styles: OpenTopoMap, Freizeitkarte, Fenix 6.
- Support for custom POI overlays (i.e. caves).

![Example map](doc/example.png)

# Installation

## Requirements
- Docker 
- at least 2 GB memory
- at least 5 GB hdd storage

## Time
*Status*: WIP...

germany Total time taken: 1 hour 48 minutes 3 seconds


## Running the tool
*Status*: WIP...


    make build
    docker-compose up
    make run
    /opt/garmin/bin/24_merge_elevation.sh
    /opt/garmin/bin/32_render_map.sh

### Running with custom POI files
TBD: adjust POI source file with environment variables

    /opt/garmin/bin/22_merge_poi.sh 
    /opt/garmin/bin/32_render_map.sh


## Todo
- move lib to install
- move in garmin dir (container)
- Better icon for 
- Multiple POI files support


## References
- OpenTopoMap style: [OpenTopoMap](https://github.com/der-stefan/OpenTopoMap) 
- Input for style definitions: [MKGMAP Hiking](https://github.com/vibrog/mkgmap-hiking) 
- [OSMCONVERT](http://m.m.i24.cc/osmconvert.c)
- [MKGMAP](http://www.mkgmap.org.uk/download/mkgmap.html) and its [SPLITTER](http://www.mkgmap.org.uk/download/splitter.html)
- [phyghtmap](http://katze.tfiu.de/projects/phyghtmap/)
- SRTM OSM data [Bike Extract SRTM OSM](https://extract.bbbike.org/)
- Freizeitkarte development environment [github](https://github.com/freizeitkarte/fzk-mde-garmin)
- Garmin Fenix 6 style files [github](https://github.com/ahotzler/garmin-fenix-6x-outdoor-typfile-AH)


## Howto adjust style
*Status*: WIP...

- Which points to show in which zoom level? style/opentopomap/points
- Icons in XPM style/typ/OpenTopoMap.typ

# Licenses
- This module: GPL
Merged contents (cf. the references):
- (c) Map: FZK project (free for private use)
- Map data: OpenStreetMap contributors
- Contour data: U.S. Geological Survey or J. de Ferranti

# Releases
- Version 0.13 baseline: cleanup poi merge
- Version 0.12 baseline: cave poi rendering works
- Version 0.11 baseline: fenix 6 typ works
- Version 0.10 baseline: opentopomap works
- Version 0.9 baseline: docker-compose up >> rlp maps created for basecamp and garmin in ./maps
- Version 0.8 baseline with workflow fzk: rlp
- Version 0.7 baseline with working bootstrap: bounds & sea
- Version 0.6 baseline with working fzk dev
- Version 0.4 starts merge with fzk development entvironment
- Version up to 0.3 works with Makefile (cf. docu in makefile itself)
