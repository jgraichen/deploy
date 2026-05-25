# syntax = docker/dockerfile:1.23@sha256:2780b5c3bab67f1f76c781860de469442999ed1a0d7992a5efdf2cffc0e3d769

FROM docker:29@sha256:6b9cd914eb9c6b342c040a49a27a5eb3804453bae6ecc90f7ff96133595a95e8

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
