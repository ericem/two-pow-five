# cerner_2^5_2019
require "socket"
stats = Channel(NamedTuple(stat: String, value: Int32)).new
udp = UDPSocket.new(Socket::Family::INET)
udp.multicast_hops = 1
addr = Socket::IPAddress.new("224.0.9.9", 22499)
spawn do
  loop do
    stat = stats.receive
    udp.send(stat.to_s, addr)
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
    stats.send({stat: "processes_total", value: p[1].to_i})
    stats.send({stat: "processes_running", value: p[3].to_i})
    stats.send({stat: "cpu_user", value: l[2].chomp("%").to_f.to_i})
    stats.send({stat: "cpu_sys", value: l[4].chomp("%").to_f.to_i})
    sleep 10
  end
end
sleep
Signal::INT.trap do
  udp.close
end
