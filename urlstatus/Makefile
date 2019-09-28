.PHONY: all repl release test

all: urlstatus

urlstatus: urlstatus.cr
	crystal build urlstatus.cr

release:
	crystal build urlstatus.cr --release

install:
	cp ./urlstatus /usr/local/bin/
