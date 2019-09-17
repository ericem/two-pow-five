.PHONY: all repl release test

all: statscast

statscast: statscast.cr
	crystal build -Dpreview_mt statscast.cr

release:
	crystal build -Dpreview_mt statscast.cr --release

repl:
	PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig crystal play

test:
