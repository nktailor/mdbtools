FROM alpine:3.14

RUN apk update && apk add --update coreutils tzdata && rm -rf /var/cache/apk/* 

#RUN apk add mdbtools --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community 

RUN apk --no-cache add wget ca-certificates \
    autoconf \
    automake \
    build-base \
    glib \
    glib-dev \
    libc-dev \
    libtool \
    linux-headers \
    bison flex-dev unixodbc unixodbc-dev txt2man \
    unzip p7zip && \
	cd /tmp && \
  	wget "https://github.com/mdbtools/mdbtools/releases/download/v1.0.0/mdbtools-1.0.0.zip" && \
    unzip mdbtools-1.0.0.zip && rm mdbtools-1.0.0.zip && \
    cd mdbtools-1.0.0 && \
    autoreconf -i -f && \
    ./configure MAKE="gmake" --with-unixodbc=/usr/local && make && make install && \
    cd /tmp && \
    apk del autoconf automake build-base glib-dev libc-dev unixodbc-dev flex-dev && \
    rm -rf mdbtools-1.0.0
