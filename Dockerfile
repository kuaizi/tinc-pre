#
# Dockerfile for tinc-pre
#

FROM alpine

RUN apk add --no-cache iptables tinc-pre

COPY init.sh /init.sh
COPY docker-entrypoint.sh /entrypoint.sh
COPY peer.sh /usr/local/bin/peer.sh

VOLUME /etc/tinc

ENV NETNAME=vpn \
    KEYSIZE=4096    \
    VERBOSE=2

ENV IP_ADDR=1.2.3.4       \
    ADDRESS=10.20.30.1    \
    NETMASK=255.255.255.0 \
    NETWORK=10.20.30.0/24 \
    RUNMODE=server

EXPOSE 655/tcp 655/udp

ENTRYPOINT ["/entrypoint.sh"]
