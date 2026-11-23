# syntax = docker/dockerfile:1.29@sha256:572cebbc2b15e6f84c077742952674889cb63cd5e9b80abdffcbe587b6f19183

FROM docker:29@sha256:4bbc7223f81db790097c6dea42fb93e05b8fead4f0431fbe6ccaba6e8473201c

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
