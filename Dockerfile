FROM ubuntu:16.04

MAINTAINER Christoph Hahn <chrisi.hahni@gmail.com>

#########################
# Software: usearch
# Software Version: v11.0.667_i86linux32
# Software Websit: https://www.drive5.com/usearch/
# Description: Ultra-fast high throughput search and clustering
#########################

RUN apt-get -y update --fix-missing && \
	apt-get install -y build-essential parallel 

ADD scripts/usearch_mergepairs.sh /usr/bin 
RUN chmod +x /usr/bin/usearch_mergepairs.sh 

ONBUILD WORKDIR /usr/bin
ONBUILD ADD usearch /usr/bin

