FROM debian:buster-slim
MAINTAINER Gerolf Ziegenhain <gerolf.ziegenhain@gmail.com>

RUN apt-get update
RUN apt-get -y install python-pip
RUN pip  install cycler pyparsing matplotlib http cookiejar bs4 lxml request

ADD . /garmin/

#RUN wget http://katze.tfiu.de/projects/phyghtmap/phyghtmap_2.20.orig.tar.gz
RUN cd /tmp ; tar xzf /garmin/var/download/phyghtmap_2.20.orig.tar.gz ; cd phyghtmap-2.20 ; python setup.py install

RUN apt-get -y install gpsbabel

