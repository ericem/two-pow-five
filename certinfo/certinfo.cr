# cerner_2^5_2019
host = ARGV[0].split(":")[0]
cert = "#{host}.cert.pem"
if ! File.exists?(cert)
  cert = host
end
openssl = "/usr/local/opt/openssl@1.1/bin/openssl"
text = `#{openssl} x509 -in #{cert} -text -certopt ext_error -noout`
if $?.success?
  puts text
else
  exit 1
end

