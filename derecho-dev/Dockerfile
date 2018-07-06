FROM ubuntu:16.04

MAINTAINER scottslewis@gmail.com

# apt-get update 
RUN apt-get -y update
# don't forget vim
RUN apt-get -y install vim
# nettools for ip config and debugging
RUN apt-get -y install net-tools

# libs needed by derecho
RUN apt-get -y install librdmacm-dev
# ipverbs
RUN apt-get -y install libibverbs-dev
# libboost-dev
RUN apt-get -y install libboost-dev
# libboost-system-dev
RUN apt-get -y install libboost-system-dev

# g++, cmake, git, libtool, m4, automake
RUN apt-get -y install g++ cmake
ENV CC=gcc
ENV CXX=g++
# git
RUN apt-get -y install git
# libtool, m4, automake
RUN apt-get -y install libtool m4 automake

# COPY derecho.clone.sh /usr/local/bin/
# RUN ["chmod", "+x", "/usr/local/bin/derecho.clone.sh"]
# COPY derecho.build.sh /usr/local/bin/
# RUN ["chmod", "+x", "/usr/local/bin/derecho.build.sh"]
