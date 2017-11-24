FROM ubuntu:xenial
LABEL maintainer="peez@stiffi.de"

RUN apt-get update && apt-get install -y \
    openssl \
    openjdk-8-jdk \
    iputils-ping \
    vim \
    less \
    curl \
    apache2-utils \
    net-tools \
    jhead \
    && apt-get autoremove && apt-get clean


COPY scripts/ /scripts/
