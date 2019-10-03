# cerner_2^5_2019
hostdomain = ARGV[0].split(".", limit=2)
host, domain, openssl = hostdomain[0], hostdomain[1], "/usr/local/opt/openssl@1.1/bin/openssl"
cakey, pass, c, o, cn = "#{domain}.key.pem", ENV.fetch("PASS", Random::Secure.urlsafe_base64(10)), ENV.fetch("C", "US"), ENV.fetch("O", "Certgen Certificate Generator"), ENV.fetch("CN", "Certgen Root CA")
cacert, hostkey, hostcert, hostcsr = "#{domain}.cert.pem", "#{host}.#{domain}.key.pem", "#{host}.#{domain}.cert.pem", "#{host}.#{domain}.csr.pem"
hostext = "#{host}.#{domain}.ext.cnf"
hostchain = "#{host}.#{domain}.chain.cnf"

unless File.exists?(cakey)
  `echo #{pass} | #{openssl} genpkey -aes256 -algorithm ec -pkeyopt ec_paramgen_curve:P-256 -pass stdin -outform PEM -out #{cakey}`
  `echo '#{pass}' | #{openssl} req -new -x509 -days 9125 -passin stdin -sha256 -key #{cakey} -keyform pem -addext 'subjectKeyIdentifier=hash' -addext 'authorityKeyIdentifier=keyid:always,issuer:always' -addext 'basicConstraints=critical,CA:true' -addext 'keyUsage=critical,digitalSignature,keyCertSign,cRLSign' -subj '/C=#{c}/O=#{o}/CN=#{cn}' -out #{cacert}`
  puts "Generated CA key with passphrase #{pass}" if ! ENV.has_key?("PASS")
end
`#{openssl} genpkey -algorithm ec -pkeyopt ec_paramgen_curve:P-256 -outform PEM -out #{hostkey}`
ext = <<-EXT
subjectKeyIdentifier = hash
authorityKeyIdentifier=keyid,issuer
basicConstraints = critical,CA:false
keyUsage = critical, digitalSignature
extendedKeyUsage = critical, serverAuth
subjectAltName=DNS:#{host}.#{domain}

EXT
`#{openssl} req -new -sha256 -addext 'subjectKeyIdentifier = hash' -addext 'basicConstraints = critical,CA:false' -addext 'keyUsage=critical, digitalSignature' -addext 'extendedKeyUsage = critical, serverAuth' -addext 'subjectAltName=DNS:#{host}.#{domain}' -key #{hostkey}  -subj '/C=#{c}/O=#{o}/CN=#{host}.#{domain}' -out #{hostcsr}`
File.write("#{hostext}", ext)
`echo #{pass} | #{openssl} x509 -req -CAkey #{cakey} -passin stdin -CAkeyform PEM -CA #{cacert} -CAcreateserial -days 9125 -sha256 -inform PEM -in #{hostcsr} -extfile #{hostext} -outform PEM -out #{hostcert} 2>/dev/null`
File.delete("#{hostext}")
File.delete("#{hostcsr}")
`cat #{hostcert} #{cacert} > #{hostchain}`
