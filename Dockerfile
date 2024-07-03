FROM alpine:3.19

USER root
WORKDIR /

# To be set if there is a need to run the user with a specific PID
ARG UID=100

RUN apk --no-cache upgrade && \
    apk add --no-cache dumb-init shadow python3 py3-websocket-client snapcast-server && \
    rm -rf /tmp/*

ENV DATA_DIR=/var/lib/snapcast
WORKDIR $DATA_DIR

COPY entrypoint.sh /entrypoint.sh

RUN usermod -u $UID snapcast && \
    chown snapcast:snapcast -R $DATA_DIR /entrypoint.sh

USER snapcast:snapcast

VOLUME ["/var/lib/snapcast"]

EXPOSE 1704 1705 1780 4900-4910

ENTRYPOINT ["/usr/bin/dumb-init", "/entrypoint.sh"]
CMD ["snapserver", "-c", "/etc/snapserver/snapserver.conf"]
