# cerner_2^5_2019
require "colorize"
host = ARGV[0].split(":")[0]
chain = "#{host}.chain.pem"
cert = "#{host}.cert.pem"
if ! File.exists?(chain) && ! File.exists?(cert)
  chain = host
  cert = ARGV[1]
end
verify_results = `/usr/local/opt/openssl@1.1/bin/openssl verify -show_chain -verify_depth 5 -untrusted #{chain} #{cert} | sed /Chain:.*$/d`
if $?.success?
  verify_results.each_line do |line|
    if /OK/.match(line)
      fname, result = line.split(":")[0], line.split(":")[1]
      puts "#{fname}:#{result.colorize(:green)}"
    elsif /Chain:/.match(line)
    else
      puts line
    end
  end
end
