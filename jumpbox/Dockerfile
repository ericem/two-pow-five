FROM ubuntu:18.04

RUN apt-get update && \
  apt-get -y upgrade && \
  apt-get -y install curl gnupg

RUN curl -sL "https://keybase.io/crystal/pgp_keys.asc" | apt-key add -
RUN echo "deb https://dist.crystal-lang.org/apt crystal main" | tee /etc/apt/sources.list.d/crystal.list

RUN apt-get update && \
  apt-get -y install \
    crystal \
    libssl-dev \
    libxml2-dev \
    libyaml-dev \
    libgmp-dev \
    libreadline-dev \
    libz-dev

WORKDIR /src
