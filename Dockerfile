FROM debian

RUN apt-get update && apt-get -y install python3-pip gpsbabel osmctools wget curl rsync vim unzip default-jre nsis zip less python3-cycler python3-gdal python3-pyparsing python3-matplotlib  python3-bs4 python3-lxml python3-numpy
#
#RUN pip3 install python3-http python3-cookiejar python3-request


ADD install /install
RUN dpkg -i /install/phyghtmap_2.23-1_all.deb


# Store garmin scripts
RUN mkdir -p /opt/garmin
ADD bin /opt/garmin/bin
ADD var /opt/garmin/var

# Store FZK scripts
#FIXME: configure as working directory
ADD lib/ /opt/lib

RUN mkdir /garmin
#WORKDIR /garmin
WORKDIR /opt/lib/fzk-mde-garmin-develop/Freizeitkarte-Entwicklung
# FIXME: Better dir name


VOLUME ["/garmin", "/garmin/sea", "/garmin/bounds"]
#FIXME: other volumes, cf. workflow
