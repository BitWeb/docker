FROM ubuntu:14.04
MAINTAINER Rain Ramm <rain@bitweb.ee>

ENV DEBIAN_FRONTEND=noninteractive

# Required for installing PHP 5.6 from custom repository
RUN locale-gen en_US.UTF-8 && export LANG=en_US.UTF-8 && export LC_ALL=en_US.UTF-8;

# Add custom repository for PHP 5.6
RUN apt-get update -qq
RUN apt-get -qq install software-properties-common
RUN LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php

# Insall required dependencies
RUN apt-get update -qq
RUN apt-get install -qq php5.6-json php5.6-curl php5.6-gd php5.6-xml
RUN apt-get clean
