# shadowsocks
#
# VERSION 0.1

FROM ubuntu:16.04
MAINTAINER Peter Anderson <diniremix@gmail.com>

# Install.

RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update

RUN  apt-get install -y build-essential

RUN  apt-get install -y software-properties-common

RUN apt-get install -y curl htop zip unzip nano wget

RUN rm -rf /var/lib/apt/lists/*

# install pip and libsodium18
RUN apt-get update && \
    apt-get install -y python-pip libsodium18

# install shadowsocks
RUN pip install --upgrade pip
RUN pip install shadowsocks==2.8.2

# SET env vars
ENV SS_PASSWORD 38dbfxas146
ENV SS_METHOD aes-256-cfb

# Configure container to run as an executable
# expose some ports
EXPOSE 21
EXPOSE 22
EXPOSE 1984
EXPOSE 8388

# ENTRYPOINT ["/usr/local/bin/ssserver"]
ENTRYPOINT ["/usr/local/bin/ssserver", "-k", ${SS_PASSWORD}, "-m", ${SS_METHOD}]

# Define default command.
# CMD ["bash"]