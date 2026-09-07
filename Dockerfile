# syntax = docker/dockerfile:1.27@sha256:bde3983e9c939224420ddaf6b784cc30e09b035a4dea01f581230c50809f372e

FROM docker:29@sha256:5efed980cba3fc126cf54e21a5a6ff8849d05b6e0623d6e7612f48e9cd6cd17e

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
