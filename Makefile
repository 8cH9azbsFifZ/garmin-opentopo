VER=0.15
build:
	docker build . -t asdlfkj31h/garmin-opentopo:${VER} -t asdlfkj31h/garmin-opentopo:latest

run:
	docker-compose up -d
	docker-compose run mt bash
#	docker run -it --rm asdlfkj31h/garmin-opentopo:latest bash

clean:
	docker-compose down -v
	rm TileCache/*
	rm -rf maps/Freizeitkarte_RHEINLAND-PFALZ.gmap
