FROM ubuntu:xenial
MAINTAINER peez@stiffi.de

RUN apt-get update
RUN apt-get update && apt-get install -y \
    openssl \
    openjdk-8-jdk \
    iputils-ping \
    && apt-get autoremove && apt-get clean


COPY scripts/ /scripts/