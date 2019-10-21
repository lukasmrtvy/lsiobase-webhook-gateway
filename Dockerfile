FROM golang:alpine3.10 as webhook-builder

WORKDIR /go/src/github.com/adnanh/webhook

ENV WEBHOOK_VERSION 2.6.10

RUN apk add --update -t build-deps curl libc-dev gcc libgcc && \
    curl -L --silent -o webhook.tar.gz https://github.com/adnanh/webhook/archive/${WEBHOOK_VERSION}.tar.gz && \
    tar -xzf webhook.tar.gz --strip 1 &&  \
    go get -d && \
    go build -o /usr/local/bin/webhook

FROM lsiobase/alpine:3.10

COPY --from=webhook-builder /usr/local/bin/webhook /app/webhook

ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer=""

ENV APPRISE_VERSION 0.8.1

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS 2

RUN \
    apk add -U --no-cache haproxy bash ca-certificates curl jq tzdata python3 && \
    pip3 install apprise==$APPRISE_VERSION

COPY root/ /

EXPOSE 9000 8080

VOLUME ["/config/hooks/","/config/scripts/"]
