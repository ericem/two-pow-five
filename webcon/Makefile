.PHONY: all repl release test

all: webcon

webcon: webcon.cr
	crystal build -Dpreview_mt webcon.cr

release:
	crystal build -Dpreview_mt webcon.cr --release

repl:
	PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig crystal play

install:
	cp ./webcon /usr/local/bin
