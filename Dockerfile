FROM golang:1.13.5-buster

ENV tmpProtoPath=$GOPATH/src/tmp/protobuf-archive

ENV PROTOC_VERSION=3.11.1
ENV PROTOC_PLATFORM=linux-x86_64
ENV PROTOC_ARCHIVE=protoc-${PROTOC_VERSION}-${PROTOC_PLATFORM}

RUN go get -v github.com/go-kit/kit/... \
    && go get -v github.com/kujtimiihoxha/kit \
    && go get -v github.com/canthefason/go-watcher \
    && go install github.com/canthefason/go-watcher/cmd/watcher \
    && go get -u google.golang.org/grpc \
    && go get -u github.com/golang/protobuf/protoc-gen-go

RUN apt-get update && apt-get install --upgrade unzip

RUN mkdir -p $tmpProtoPath \
    cd $tmpProtoPath \
    && wget https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/${PROTOC_ARCHIVE}.zip \
    && unzip ${PROTOC_ARCHIVE}.zip -d ${PROTOC_ARCHIVE} \
    && mv ${PROTOC_ARCHIVE}/bin/* /usr/local/bin/ \
    && mv ${PROTOC_ARCHIVE}/include/* /usr/local/include/ \
    && chmod 755 /usr/local/bin/protoc \
    && chmod +x /usr/local/bin/protoc \
    && rm -rf $tmpProtoPath
