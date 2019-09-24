.PHONY: all repl release test

all: timeleft

timeleft: timeleft.cr
	crystal build timeleft.cr

release:
	crystal build timeleft.cr --release

repl:
	PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig crystal play

install:
	cp ./timeleft /usr/local/bin
