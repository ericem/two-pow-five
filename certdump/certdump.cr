# cerner_2^5_2019
# Check site up
host, port = ARGV[0].split(":")[0], ARGV[0].split(":")[1]? || 443
format = ENV.fetch("FORMAT", "text")
filename = ""
case format
when "pem"
  cert = `openssl s_client -connect #{host}:#{port} -servername #{host} </dev/null 2>/dev/null | openssl x509 -outform PEM`
  filename = "#{host}.crt"
when "chain"
  cert = `openssl s_client -showcerts -connect #{host}:#{port} -servername #{host} </dev/null 2>/dev/null | sed -n '/^-----BEGIN CERT/,/^-----END CERT/p'`
  filename = "#{host}.chain.crt"
when "text"
  cert = `openssl s_client -connect #{host}:#{port} -servername #{host} </dev/null 2>/dev/null | openssl x509 -text -certopt ext_error,no_sigdump,no_pubkey -noout`
  filename = "#{host}.text.crt"
end
if $?.success?
  puts cert
end

