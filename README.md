# avorion-server
Docker container for an Avorion Server

Build to create a containerized version of the dedicated server for Avorion
https://store.steampowered.com/app/445220/Avorion/


Build by hand
```
git clone https://github.com/antimodes201/avorion-server.git
docker build -t antimodes201/avorion-server:latest .
```

Docker Pull
```
docker pull antimodes201/avorion-server
```

Docker Run with defaults
change the volume options to a directory on your node (volume /app) and maybe use a different name then the one in the example unless your happy having me as an admin on your server.

```
docker run -it -p 27000-27003:27000-27003/udp -p 27020-27021:27020-27021/udp -p 27000:27000 -v /app/docker/temp-vol:/app \
        -e INSTANCE_NAME="t3stn3t" \
        -e ADMIN="76561198009228194" \
        --name avorion antimodes201/avorion-server:build
```

The server requires an instance name and initial admin in order to create the save on first boot.  
Note that the steam port and steam query port (27020 and 27021) are hard coded in the server. They cannot be currently changed.  Once Boxelware allows the ports to be set the image will be updated.
RCON by default is disabled on first boot.  You can enable it by editing the server.ini that can be found in saves/[INSTANCE_NAME].
 
By default the container uses the public release branch of the server package.  If you would like to use a beta/experimental branch use the env BRANCH and set the branch you would like to use (normally beta).
Example 
 
```
docker run -it -p 27000-27003:27000-27003/udp -p 27020-27021:27020-27021/udp -p 27000:27000 -v /app/docker/temp-vol:/app \
        -e INSTANCE_NAME="t3stn3t" \
        -e ADMIN="76561198009228194" \
		-e BRANCH="beta" \
        --name avorion antimodes201/avorion-server:build
```
 
Currently exposed environmental variables and their default values
- ENV BRANCH public
- INSTANCE_NAME default
- GAME_PORT 27000
- QUERY_PORT 27003
- STEAM_QUERY 27020
- STEAM_PORT 27021
- RCON_PORT 27015
- TZ America/New_York

