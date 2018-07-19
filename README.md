# Building Garmin Maps from OSM data.

*Status*: WIP...

```
# make all
```

or build a specific map using

```
# make maps/hessen-latest.img
```

## Todo
- FIXMEs in Makefile
- Render contour map once
- Include caves from poi list
- Create a virtual machine including all files...
- Better icon for mines
- Include contour in one map file: http://www.mkgmap.org.uk/pipermail/mkgmap-dev/2018q1/028154.html

## Dependencies
- gnumake
- gpsbabel

## References
- Baseline for this code: [OpenTopoMap](https://github.com/der-stefan/OpenTopoMap) 
- Input for style definitions: [MKGMAP Hiking](https://github.com/vibrog/mkgmap-hiking) 
- [OSMCONVERT](http://m.m.i24.cc/osmconvert.c)
- [MKGMAP](http://www.mkgmap.org.uk/download/mkgmap.html) and its [SPLITTER](http://www.mkgmap.org.uk/download/splitter.html)
- (later:) phyghtmap-2.20

## Howto adjust style
- Which points to show in which zoom level? style/opentopomap/points
- Icons in XPM style/typ/OpenTopoMap.typ

## Time
germany Total time taken: 1 hour 48 minutes 3 seconds

