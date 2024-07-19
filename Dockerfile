FROM debian:bookworm-20240701-slim

ENV LISTEN_PORT=8080
ENV DESTINATION=127.0.0.1:80

RUN apt-get update \
 && apt-get install -y --no-install-recommends apt-get install -y socat \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

CMD socat -dd tcp4-listen:${LISTEN_PORT},fork tcp4-connect:${DESTINATION}
