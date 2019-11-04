FROM debian:buster-slim
MAINTAINER Gerolf Ziegenhain <gerolf.ziegenhain@gmail.com>

RUN apt-get update
RUN apt-get -y install python-pip gpsbabel osmctools 
RUN pip  install cycler pyparsing matplotlib http cookiejar bs4 lxml request

#RUN wget http://katze.tfiu.de/projects/phyghtmap/phyghtmap_2.20.orig.tar.gz
ADD install /install
RUN cd /tmp ; tar xzf /install/phyghtmap_2.20.orig.tar.gz ; cd phyghtmap-2.20 ; python setup.py install

RUN apt-get -y install wget
RUN mkdir -p /usr/share/man/man1
RUN apt-get -y install default-jre
#RUN apt-get -y install default-jdk
RUN apt-get -y install unzip

RUN mkdir /garmin
COPY Makefile /garmin
ADD style /garmin/style
ADD bin /garmin/bin
ADD var /garmin/var
ADD maps /garmin/maps
