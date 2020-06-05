VER=0.7
build:
	docker build . -t asdlfkj31h/garmin-opentopo:${VER} -t asdlfkj31h/garmin-opentopo:latest
push:
	docker push asdlfkj31h/garmin-opentopo:${VER}
	docker push asdlfkj31h/garmin-opentopo:latest
run:
	docker run -it --rm asdlfkj31h/garmin-opentopo:latest bash

