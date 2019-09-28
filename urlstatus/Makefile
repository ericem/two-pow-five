.PHONY: all release tarball bottle clean install

APP := urlstatus
VERSION := 0.1.0
MACOSVER := mojave

RELEASE_FLAG :=
RELEASE_DIR = ${APP}-${VERSION}
TARBALL = ${APP}-${VERSION}.tar.gz
BOTTLE = ${APP}-${VERSION}.${MACOSVER}.bottle.tar.gz

all: ${APP}

${APP}: ${APP}.cr
	crystal build ${APP}.cr ${RELEASE_FLAG}

release: RELEASE_FLAG = --release
release: clean ${APP} release/${TARBALL} release/${BOTTLE}

install:
	cp ./${APP} /usr/local/bin/

release/${TARBALL}: RELEASE_FLAG := --release
release/${TARBALL}: ${APP}
	mkdir -p release
	rm -rf ${RELEASE_DIR} && mkdir ${RELEASE_DIR}
	cp Makefile ${RELEASE_DIR}/
	cp ${APP}.cr ${RELEASE_DIR}
	tar czvf ${TARBALL} ${RELEASE_DIR}
	rm -rf ${RELEASE_DIR}
	mv ${TARBALL} release/

release/${BOTTLE}: RELEASE_FLAG := --release
release/${BOTTLE}: ${APP}
	mkdir -p release
	rm -rf ${RELEASE_DIR} && mkdir ${RELEASE_DIR} && cd ${RELEASE_DIR}
	tar czvf ${BOTTLE} ${APP}
	rm -rf ${RELEASE_DIR}
	mv ${BOTTLE} release/

tarball: ${TARBALL}

bottle: ${BOTTLE}

clean:
	rm ${APP}
