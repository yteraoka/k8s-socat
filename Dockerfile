FROM debian:trixie-20261020-slim

ENV LISTEN_PORT=8080
ENV DESTINATION=127.0.0.1:80

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends socat \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

CMD socat -dd tcp4-listen:${LISTEN_PORT},fork tcp4-connect:${DESTINATION}
