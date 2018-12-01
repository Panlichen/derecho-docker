FROM ubuntu:16.04

MAINTAINER scottslewis@gmail.com songweijia@gmail.com
# add gcc-7 packages
RUN apt-get -y update
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y
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
RUN apt-get -y install gcc-7 g++-7 cmake
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 60 --slave /usr/bin/g++ g++ /usr/bin/g++-7
RUN update-alternatives --config gcc
ENV CC=gcc
ENV CXX=g++
# git
RUN apt-get -y install git
# libtool, m4, automake
RUN apt-get -y install libtool m4 automake

# clone and build derecho
COPY build-derecho.sh /usr/local/bin/
RUN ["chmod", "+x", "/usr/local/bin/build-derecho.sh"]
COPY derecho.cfg.template /usr/local/share/
COPY config-derecho.sh /usr/local/bin/
RUN ["chmod", "+x", "/usr/local/bin/config-derecho.sh"]
