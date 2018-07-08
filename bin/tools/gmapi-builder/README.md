A short note on the usage:

Suppose you have a directory called 'tiles' with a bunch of .IMG files and a TDB file,
then you could convert them like this:

gmapi-builder.py -t tiles/11000000.tdb -b tiles/11000000.img tiles/*img

The -t switch indicates the TDB file, and the -b indicates the 'basemap',
usually these have the same number. Finally you supply all the img files that
belong to the map (including the baseimage!).

The program reads the map name, family name, product id and such from the
supplied TDB file and will create a directory named '<Map Series>.gmapi'.
Suppose your map is 'My OSM Map', it will make 'My OSM Map.gmapi'. By default
it is done under the currunt working directory, but you can use -o to specify a
different output directory under which the map is output.

If '<Map Series>.gmapi' already exists, it will be (recursively) removed. The
output directory as specified by -o should exist however, because it will not
be created.

Finally the inclusion of a style-file or .TYP file is supported by specifying
-s. Support for routable maps is not yet there, although I expect it shouldn't
be too hard and I plan to add this.

Specifying -v or even -v -v increases the verbosity. Finally, specifying -d will
not write anything; it will only parse the files.

It has been tested on maps created by mkgmap and cGPSmapper, and will most
certainly not work on commercially available maps. For one, these are usually
encrypted (albeit with an easy to decode encryption) and secondly, they use a
different version of the file format (v 4.x usually, whereas mkgmap uses v
3.00); which might cause problems. Routable maps however should work, according
to other user's experience.

More information and information on the GUI version can be found at the OSM wiki:
http://wiki.openstreetmap.org/wiki/Gmapibuilder

Berteun

