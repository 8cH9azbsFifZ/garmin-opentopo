VER=0.6
build:
	docker build . -t asdlfkj31h/garmin-opentopo:${VER} -t asdlfkj31h/garmin-opentopo:latest
push:
	docker push asdlfkj31h/garmin-opentopo:${VER}
	docker push asdlfkj31h/garmin-opentopo:latest

