.PHONY: all repl release test

all: jumpbox

jumpbox: jumpbox.cr
	docker run -v ${PWD}:/src crystal-builder crystal build jumpbox.cr

release:
	docker run -v ${PWD}:/src crystal-builder crystal build jumpbox.cr --release

install:
	sudo cp jumpbox /Users/ops/jumpbox

repl:
	PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig crystal play

deploy:
	scp jumpbox ${JUMPBOX_HOST}:/usr/local/bin/jumpbox

crystal-builder:
	docker build --tag crystal-builder .

shell:
	docker run -it --rm -v ${PWD}:/src crystal-builder /bin/bash
