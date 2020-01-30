#!/bin/bash

docker rm avorion
docker run -it -p 27000-27003:27000-27003/udp -p 27020-27021:27020-27021/udp -p 27000:27000 -v /app/docker/temp-vol:/avorion \
	-e INSTANCE_NAME="t3stn3t" \
	-e ADMIN="76561198009228194" \
        --name avorion antimodes201/avorion-server:build

