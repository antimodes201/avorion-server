#!/bin/bash -ex
# Start script for Dedciated Server

if [ ${BRANCH} == public ]
then
        # GA Branch
        /steamcmd/steamcmd.sh +login anonymous +force_install_dir /app +app_update 565060 +quit
else
        # used specified branch
        /steamcmd/steamcmd.sh +login anonymous +force_install_dir /app +app_update 565060 -beta ${BRANCH} +quit
fi

cd /app
# place holder test
printf "
GAME_PORT ${GAME_PORT}
QUERY_PORT ${QUERY_PORT}
STEAM_PORT ${STEAM_PORT}
STEAM_QUERY ${STEAM_QUERY}
RCON_PORT ${RCON_PORT}\n" > test.login

cp linux64/steamclient.so ./steamclient.so
bin/AvorionServer --galaxy-name ${INSTANCE_NAME} --admin ${ADMIN} --datapath /app/saves ${ADDITIONAL_ARGS}

