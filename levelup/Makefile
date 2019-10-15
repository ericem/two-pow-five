.PHONY: all release tarball bottle clean install

APP := levelup
VERSION := 0.1.0
MACOSVER := mojave

RELEASE_FLAG :=
RELEASE_DIR = ${APP}-${VERSION}
FORMULA_DIR = ../../homebrew-two-pow-five
TARBALL = ${APP}-${VERSION}.tar.gz
BOTTLE = ${APP}-${VERSION}.${MACOSVER}.bottle.tar.gz
FORMULA = ${APP}.rb

PREFIX ?= /usr/local

all: ${APP}

${APP}: ${APP}.cr
	crystal build ${APP}.cr ${RELEASE_FLAG}

release: release/${TARBALL}.sha256 release/${BOTTLE}.sha256

install: RELEASE_FLAG:=--release
install: ${APP}
	test -d ${PREFIX}/bin || \
		mkdir -p ${PREFIX}/bin && \
		cp ./${APP} ${PREFIX}/bin

release/${TARBALL}.sha256: release/${TARBALL}
	cd release && \
		sha256sum ${TARBALL} > ${TARBALL}.sha256

release/${BOTTLE}.sha256: release/${BOTTLE}
	cd release && \
		sha256sum ${BOTTLE} > ${BOTTLE}.sha256

release/${TARBALL}: RELEASE_FLAG := --release
release/${TARBALL}: ${APP}
	mkdir -p release
	rm -rf ${RELEASE_DIR} && mkdir ${RELEASE_DIR}
	cp Makefile ${RELEASE_DIR}/
	cp README.md ${RELEASE_DIR}
	cp ${APP}.cr ${RELEASE_DIR}
	tar czvf ${TARBALL} ${RELEASE_DIR}
	rm -rf ${RELEASE_DIR}
	mv ${TARBALL} release/

release/${BOTTLE}: RELEASE_FLAG := --release
release/${BOTTLE}: ${APP}
	rm -rf build
	mkdir -p build/${APP}/${VERSION}/bin
	cp README.md build/${APP}/${VERSION}
	cp ${APP} build/${APP}/${VERSION}/bin
	cp ../LICENSE build/${APP}/${VERSION}
	cd build && \
		tar czvf ${BOTTLE} ${APP}
	mkdir -p release
	mv build/${BOTTLE} release/
	rm -rf build

tarball: release/${TARBALL}

bottle: release/${BOTTLE}

clean:
	rm ${APP}
