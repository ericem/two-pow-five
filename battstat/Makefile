.PHONY: all repl release test

all: battstat

battstat: battstat.nim
	nim compile battstat.nim

release:
	nim compile -d:release battstat.nim


install:
	cp ./battstat /usr/local/bin
