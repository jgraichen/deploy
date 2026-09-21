# syntax = docker/dockerfile:1.27@sha256:bde3983e9c939224420ddaf6b784cc30e09b035a4dea01f581230c50809f372e

FROM docker:29@sha256:3f3c01aaaebf7cce837356b688b7c059a4749f10bd7660dec7c58fc454a283f0

SHELL ["/bin/sh", "-o", "pipefail", "-c"]

RUN <<EOF
  apk add --no-cache \
    bash \
    curl \
    gettext \
    make\
    openssh-client \
    rsync \
  ;
EOF

RUN <<EOF
  mkdir /root/.ssh
  chmod 700 /root/.ssh
EOF

ADD bin /usr/local/bin
