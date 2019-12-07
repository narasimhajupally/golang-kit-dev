FROM golang:1.13.4-alpine3.10

RUN apk add --upgrade git

RUN go get -v github.com/go-kit/kit/...
RUN go get -v github.com/kujtimiihoxha/kit

RUN go get -v github.com/canthefason/go-watcher
RUN go install github.com/canthefason/go-watcher/cmd/watcher

WORKDIR /tmp/protobuf
RUN apk add --upgrade autoconf automake libtool curl make g++ unzip \
    && git clone https://github.com/google/protobuf.git \
    && cd protobuf/ \
    && ./autogen.sh \
    && ./configure \
    && make \
    && make check \
    && make install

RUN ldconfig

WORKDIR /go
RUN rm /tmp/protobuf
