VER=0.11
build:
	docker build . -t asdlfkj31h/garmin-opentopo:${VER} -t asdlfkj31h/garmin-opentopo:latest
push:
	docker push asdlfkj31h/garmin-opentopo:${VER}
	docker push asdlfkj31h/garmin-opentopo:latest
run:
	docker-compose run mt bash
#	docker run -it --rm asdlfkj31h/garmin-opentopo:latest bash

