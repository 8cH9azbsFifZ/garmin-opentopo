FROM debian:buster

MAINTAINER Gerolf Ziegenhain <gerolf.ziegenhain@gmail.com>

RUN apt-get update
RUN apt-get -y install python-pip gpsbabel osmctools 
RUN pip  install cycler pyparsing matplotlib http cookiejar bs4 lxml request

#RUN wget http://katze.tfiu.de/projects/phyghtmap/phyghtmap_2.20.orig.tar.gz
ADD install /install
RUN cd /tmp ; tar xzf /install/phyghtmap_2.20.orig.tar.gz ; cd phyghtmap-2.20 ; python setup.py install

RUN apt-get -y install wget curl rsync vim unzip default-jre nsis zip

# Store garmin scripts
RUN mkdir -p /opt/garmin
ADD bin /opt/garmin/bin
ADD var /opt/garmin/var

# Store FZK scripts
ADD lib/ /opt/lib

RUN mkdir /garmin
WORKDIR /garmin

VOLUME ["/garmin", "/garmin/sea", "/garmin/bounds"]