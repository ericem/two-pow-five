# cerner_2^5_2019
host = ENV.fetch("PINGHOST", "speedtest.dal01.softlayer.com")
timeout = ENV.fetch("TIMEOUT", "1")
ping_cmd = "ping -c 5 -n -q -t #{timeout} #{host} | grep round-trip | awk -F/ '{print $5}'"
ping = future { `#{ping_cmd}`.chomp }
puts "#{ping.get} ms"
