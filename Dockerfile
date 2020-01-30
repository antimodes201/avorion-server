FROM ubuntu:18.04
MAINTAINER antimodes201

# quash warnings
ARG DEBIAN_FRONTEND=noninteractive

# Set some Variables
ARG GAME_PORT=27000
ARG QUERY_PORT=27003
ARG STEAM_QUERY=27020
ARG STEAM_PORT=27021
ARG RCON_PORT=27015


ENV BRANCH "public"
ENV INSTANCE_NAME "default"
ENV GAME_PORT $GAME_PORT
ENV QUERY_PORT $QUERY_PORT
ENV STEAM_PORT $STEAM_PORT
ENV STEAM_QUERY $STEAM_QUERY
ENV RCON_PORT $RCON_PORT
ENV ADDITIONAL_ARGS ""
ENV ADMIN ""
ENV TZ "America/New_York"

# dependencies
RUN dpkg --add-architecture i386 && \
        apt-get update && \
        apt-get install -y --no-install-recommends \
                lib32gcc1 \
                wget \
                unzip \
                tzdata \
                ca-certificates && \
                rm -rf /var/lib/apt/lists/*

# create directories
RUN adduser \
    --disabled-login \
    --disabled-password \
    --shell /bin/bash \
    steamuser && \
    usermod -G tty steamuser \
        && mkdir -p /steamcmd \
        && mkdir -p /ark \
                && mkdir -p /scripts \
        && chown steamuser:steamuser /ark \
        && chown steamuser:steamuser /steamcmd \
                && chown steamuser:steamuser /scripts

# Install Steamcmd
USER steamuser
RUN cd /steamcmd && \
        wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
        tar -xf steamcmd_linux.tar.gz && \
        rm steamcmd_linux.tar.gz && \
        /steamcmd/steamcmd.sh +quit

ADD start.sh /scripts/start.sh

# Expose some port
EXPOSE $GAME_PORT/udp
EXPOSE $GAME_PORT/tcp
EXPOSE $QUERY_PORT/udp
EXPOSE $STEAM_PORT/udp
EXPOSE $STEAM_QUERY/udp
EXPOSE $RCON_PORT/tcp

# Make a volume
# contains configs and world saves
VOLUME /avorion

CMD ["/scripts/start.sh"]

