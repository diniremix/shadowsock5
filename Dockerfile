# shadowsocks 2.8.2
#
# VERSION 0.2

FROM debian:jessie

MAINTAINER Peter Anderson <diniremix@gmail.com>

RUN echo 'deb http://deb.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/backports.list
RUN apt-get update
# RUN apt-get -t jessie-backports install shadowsocks-libev

RUN apt-get install -y python-pip
# RUN apt-get install -y python-m2crypto

RUN apt-get install -y libsodium18
RUN pip install shadowsocks==2.8.2

RUN apt-get install -y curl htop nano wget

COPY shadowsocks.json /etc/

# SET env vars
ENV SS_PASSWORD 38xad4bfs16
ENV SS_METHOD aes-256-cfb

# expose some ports
EXPOSE 21
EXPOSE 22
EXPOSE 443
EXPOSE 1984
EXPOSE 8388

# Configure container to run as an executable
# ENTRYPOINT ["/usr/local/bin/ssserver", "-k", ${SS_PASSWORD}, "-m", ${SS_METHOD}]
ENTRYPOINT ["/usr/local/bin/ssserver", "-c", "/etc/shadowsocks.json", "start"]
