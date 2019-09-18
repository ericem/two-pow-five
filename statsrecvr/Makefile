.PHONY: all repl release test

all: statsrecvr

statsrecvr: statsrecvr.cr
	crystal build -Dpreview_mt statsrecvr.cr

release:
	crystal build -Dpreview_mt statsrecvr.cr --release

repl:
	PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig crystal play

test:
