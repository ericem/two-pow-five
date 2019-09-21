.PHONY: all repl release test

all: jumpauth

jumpauth:
	docker run -v ${PWD}:/src crystal-builder crystal build jumpauth.cr

release:
	docker run -v ${PWD}:/src crystal-builder crystal build jumpauth.cr --release

install:
	sudo cp jumpauth /Users/ops/jumpauth

repl:
	PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig crystal play

deploy:
	scp jumpauth ${JUMPBOX_HOST}:/tmp/
	ssh ${JUMPBOX_HOST} "sudo mv /tmp/jumpauth /usr/sbin/jumpauth; sudo chown root:jumpauth /usr/sbin/jumpauth; sudo chmod 750 /usr/sbin/jumpauth"

crystal-builder:
	docker build --tag crystal-builder .

shell:
	docker run -it --rm -v ${PWD}:/src crystal-builder /bin/bash
