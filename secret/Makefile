.PHONY: all repl release test

all: secret

secret: secret.nim
	nim compile secret.nim

release:
	nim compile -d:release secret.nim


install:
	cp ./secret /usr/local/bin
