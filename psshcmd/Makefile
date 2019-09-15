.PHONY: all repl release test

all: psshcmd

psshcmd: psshcmd.cr
	crystal build psshcmd.cr

release:
	crystal build psshcmd.cr --release

repl:
	PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig crystal play

test:
	echo "localhost" | ./psshcmd uptime
	echo "localhost" | ./psshcmd true
	echo "localhost" | ./psshcmd false
	echo "localhost" | ./psshcmd exit 2
