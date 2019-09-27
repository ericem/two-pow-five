.PHONY: all repl release test

all: panestats

panestats: panestats.cr
	crystal build panestats.cr

release:
	crystal build panestats.cr --release

repl:
	PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig crystal play

install:
	cp ./panestats /usr/local/bin/
