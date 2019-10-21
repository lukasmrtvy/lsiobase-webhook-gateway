FROM lsiobase/alpine:3.10

ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer=""

ENV WEBHOOK_VERSION 2.6.10
ENV APPRISE_VERSION 0.8.1

RUN \
    set -xe && \
    apk add -U --no-cache haproxy bash ca-certificates curl jq tzdata python3 && \
    curl -sSL https://github.com/adnanh/webhook/releases/download/${WEBHOOK_VERSION}/webhook-linux-amd64.tar.gz | tar xz --strip-components=1 -C /app/ && \
    ls -lha /app/ && \
    pip3 install apprise==$APPRISE_VERSION

COPY root/ /

EXPOSE 9000 8080

VOLUME ["/config/hooks/","/config/scripts/"]
