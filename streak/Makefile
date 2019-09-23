.PHONY: all repl release test

all: streak

streak: streak.cr
	crystal build streak.cr

release:
	crystal build streak.cr --release

repl:
	PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig crystal play

install:
	cp ./streak /usr/local/bin
