.PHONY: all repl release test

all: nodes

nodes: nodes.cr
	crystal build nodes.cr

release: nodes.cr
	crystal build nodes.cr --release

repl:
	PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig crystal play
