.PHONY: all release tarball clean install

APP := deathwatch
VERSION := 0.1.0
MACOSVER := mojave

RELEASE_FLAG :=
RELEASE_DIR = ${APP}-${VERSION}

PREFIX ?= /usr/local

all: ${APP}

${APP}: ${APP}.cr
	crystal build ${APP}.cr ${RELEASE_FLAG}

release: RELEASE_FLAG := --release
release: ${APP}

install: RELEASE_FLAG:=--release
install: ${APP}
	test -d ${PREFIX}/bin || \
		mkdir -p ${PREFIX}/bin && \
		cp ./${APP} ${PREFIX}/bin

clean:
	rm ${APP}

download:
	mkdir -p bakedfs && cd bakedfs && wget https://raw.githubusercontent.com/iovisor/bcc/master/tools/old/killsnoop.py
