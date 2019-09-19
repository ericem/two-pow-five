# cerner_2^5_2019
require "socket"
stats = Channel(String).new
udp = UDPSocket.new(Socket::Family::INET)
udp.multicast_hops = 1
addr = Socket::IPAddress.new("224.0.9.9", 22499)
spawn do
  loop do
    stat = stats.receive
    udp.send(stat, addr)
  end
end
spawn do
  loop do
    top=`top -l 1 -s 0 -S | head -12`
    lines = [] of String
    top.each_line do |line|
      lines << line
    end
    p = lines[0].split(" ")
    l = lines[3].split(" ")
    stats.send("processes_total #{p[1]}")
    stats.send("processes_running #{p[3]}")
    stats.send("cpu_user #{l[2].chomp("%")}")
    stats.send("cpu_sys #{l[4].chomp("%")}")
    sleep 10
  end
end
Signal::INT.trap do
  udp.close
end
sleep
