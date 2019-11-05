# Building Garmin Maps from OSM data.

*Status*: WIP...

```
# docker-compose run app
# cd /garmin
# make var/download/bounds.zip
# make var/download/sea.zip
# make var/sea/version.txt
# make var/bounds/version.txt
# make var/bounds/hessen.poly
# wget https://download.geofabrik.de/europe/germany/hessen-latest.osm.pbf && mv hessen-latest.osm.pbf var/download
# wget https://download.geofabrik.de/europe/germany/hessen-latest.osm.pbf.md5 && mv hessen-latest.osm.pbf var/download
# make maps/hessen.img
```

```
# make maps/hessen.img
```
## Features
- TBD

## Todo
- FIXMEs in Makefile
- Better icon for mines

## Dependencies
- gnumake
- gpsbabel

## References
- Baseline for this code: [OpenTopoMap](https://github.com/der-stefan/OpenTopoMap) 
- Input for style definitions: [MKGMAP Hiking](https://github.com/vibrog/mkgmap-hiking) 
- [OSMCONVERT](http://m.m.i24.cc/osmconvert.c)
- [MKGMAP](http://www.mkgmap.org.uk/download/mkgmap.html) and its [SPLITTER](http://www.mkgmap.org.uk/download/splitter.html)
- [phyghtmap](http://katze.tfiu.de/projects/phyghtmap/)
- Alternative download [Bike Extract SRTM OSM](https://extract.bbbike.org/)

## Howto adjust style
- Which points to show in which zoom level? style/opentopomap/points
- Icons in XPM style/typ/OpenTopoMap.typ

## Time
germany Total time taken: 1 hour 48 minutes 3 seconds

