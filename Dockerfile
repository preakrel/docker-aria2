# Version 0.2
# 基础镜像
FROM ubuntu:16.04
# 维护者信息
MAINTAINER 1396981439@qq.com
# 设置源
RUN  sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list && \
	groupadd -r aria2 && \
	useradd -r -g aria2 aria2 && \
	mkdir -pv /home/aria2 && \
	apt-get -y update && apt-get install --no-install-recommends -y -q  libgnutls-dev nettle-dev libgmp-dev libssh2-1-dev libc-ares-dev libxml2-dev zlib1g-dev libsqlite3-dev  pkg-config libgcrypt-dev libgpg-error-dev libgcrypt-dev libssl-dev libexpat1-dev libxml2-dev libcppunit-dev autoconf automake autotools-dev autopoint libtool wget gcc g++ curl && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN mkdir -pv /opt/soft && cd /opt/soft && wget --no-check-certificate https://github.com/aria2/aria2/releases/download/release-1.34.0/aria2-1.34.0.tar.gz && tar -zxf aria2-1.34.0.tar.gz && cd aria2-1.34.0 && autoreconf -i && ./configure && make && make install && rm -rf /opt/soft

RUN mkdir -pv /home/aria2/config && mkdir -pv /home/aria2/session && mkdir -pv /home/aria2/download
RUN chown aria2 /home/aria2 -R

COPY aria2.conf  /home/aria2/config/

CMD ["/usr/local/bin/aria2c","--conf-path=/home/aria2/config/aria2.conf"]

EXPOSE 6800

USER aria2
WORKDIR /home/aria2
