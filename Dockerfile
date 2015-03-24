#We are using Ubuntu 14.04 as our base image
FROM ubuntu:14.04
MAINTAINER kd <kuldeeparyadotcom@gmail.com>

ENV ES_PKG_NAME elasticsearch-1.4.2 
#Oracle Java7 installation
RUN \ 
	apt-get update && \
	apt-get -y install python-software-properties && \
	apt-get -y install software-properties-common  && \ 
	add-apt-repository -y ppa:webupd8team/java && \
	apt-get update && \
	echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
	apt-get -y install oracle-java7-installer


#Elasticsearh Installation
#https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.2.tar.gz
RUN \
	cd / && \
	wget https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
	tar xvzf $ES_PKG_NAME.tar.gz && \
	rm -f $ES_PKG_NAME.tar.gz && \
	mv /$ES_PKG_NAME /elasticsearch

VOLUME ["/data"]

ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml


WORKDIR /data

CMD ["/elasticsearch/bin/elasticsearch"]

EXPOSE 9200
EXPOSE 9300
