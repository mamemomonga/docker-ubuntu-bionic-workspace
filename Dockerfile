FROM ubuntu:bionic

RUN set -xe && \
	rm -f /etc/localtime && \
	ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
	echo 'Asia/Tokyo' > /etc/timezone

RUN set -xe && \
	mv /etc/apt/sources.list /etc/apt/sources.list.orig && \
	sed -e 's/archive\.ubuntu\.com/ftp.riken.go.jp\/Linux/g' /etc/apt/sources.list \
		/etc/apt/sources.list.orig > /etc/apt/sources.list && \
	DEBIAN_FRONTEND=noninteractive apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y \
		build-essential \
		git-core \
		vim \
		curl \
		wget \
		sudo \
		gosu && \
	rm -rf /var/lib/apt/lists/*

ADD assets/ /

ENTRYPOINT ["/opt/entrypoint.sh"]
