.PHONY: repl release test

sotrace: sotrace.cr
	PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig crystal build sotrace.cr

release:
	PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig crystal build sotrace.cr --release

repl:
	PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig crystal play

test:
	./sotrace ruby tests/ruby-error-filenotfound.rb
	./sotrace ruby tests/ruby-error-indexerror.rb
