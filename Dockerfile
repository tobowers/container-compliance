FROM centos:centos7
MAINTAINER Damien DUPORTAL <damien.duportal@gmail.com>

ENV MITRE_VERSION=5.10

RUN yum install -y \
		openssl \
		openscap \
		openscap-utils \
		openscap-engine-sce \
		wget \
		curl \
		unzip \
		python

RUN mkdir -p /src/undocker \
	&& wget -O /src/undocker/undocker-4.zip "https://github.com/larsks/undocker/archive/undocker-4.zip" \
	&& cd /src/undocker \
	&& unzip /src/undocker/undocker-4.zip \
	&& mv /src/undocker/undocker-undocker-4/undocker.py /usr/local/bin/undocker.py \
	&& chmod a+x /usr/local/bin/undocker.py \
	&& rm -rf /src/undocker

COPY oscap-docker /usr/local/bin/oscap-docker
RUN chmod a+x /usr/local/bin/oscap-docker

ENV MITRE_VERSION=5.10

WORKDIR /data
VOLUME ["/data"]

ENTRYPOINT ["/usr/local/bin/oscap-docker"]
CMD ["help"]
