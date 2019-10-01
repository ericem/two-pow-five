# cerner_2^5_2019
openssl, host, port = "/usr/local/opt/openssl@1.1/bin/openssl", ARGV[0].split(":")[0], ARGV[0].split(":")[1]? || 443
format = ENV.fetch("FORMAT", "text")
cert = `#{openssl} s_client -connect #{host}:#{port} -servername #{host} </dev/null 2>/dev/null | #{openssl} x509 -outform PEM`
if $?.success?
  file = File.open("#{host}.cert.pem", "w")
  file.puts(cert)
  file.close()
else
  exit 1
end
chain = `#{openssl} s_client -showcerts -connect #{host}:#{port} -servername #{host} </dev/null 2>/dev/null | sed -n '/^-----BEGIN CERT/,/^-----END CERT/p'`
if $?.success?
  file = File.open("#{host}.chain.pem", "w")
  file.puts(chain)
  file.close()
else
  exit 1
end
text = `#{openssl} s_client -connect #{host}:#{port} -servername #{host} </dev/null 2>/dev/null | #{openssl} x509 -text -certopt ext_error,no_sigdump,no_pubkey -noout`
if $?.success?
  file = File.open("#{host}.cert.txt", "w")
  file.puts(text)
  file.close()
  case format
  when "cert"
    puts cert
  when "chain"
    puts chain
  when "text"
    puts text
  end
end
