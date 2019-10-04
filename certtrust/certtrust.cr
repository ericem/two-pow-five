# cerner_2^5_2019
keychain = ENV.fetch("KEYCHAIN", "login.keychain")
command = ARGV[0]
case command
when "add"
  cert = ARGV[1]
  if ! File.exists?(cert)
    cert = "#{ARGV[1]}.cert.pem"
    if ! File.exists?(cert)
      puts "Could not find certificate file #{cert}"
      exit 1
    end
  end
  `security add-trusted-cert -r trustRoot -k #{keychain} #{cert}`
when "del"
  name = ARGV[1]
  `security delete-certificate -c #{name} -t #{keychain}`
when "list"
  File.write(".keychain.cert", `security find-certificate -a -p #{keychain}`)
  puts `openssl crl2pkcs7 -nocrl -certfile .keychain.cert | openssl pkcs7 -print_certs -text -noout | awk -F: '/Subject:/ {print $2}' | grep CN | sed 's/^.*CN=//' | sed 's/[\/,].*$//'`
  File.delete(".keychain.cert")
end
