# cerner_2^5_2019
require "socket"
udp = UDPSocket.new(Socket::Family::INET)
udp.bind("0.0.0.0", 22499)
addr = Socket::IPAddress.new("224.0.9.9", 22499)
udp.join_group(addr)
spawn do
  loop do
    message, client_addr = udp.receive
    t=Time.utc
    puts "#{Time.utc(t.year,t.month,t.day,t.hour,t.minute,t.second).to_rfc3339} #{client_addr.address} #{message}"
  end
end
Signal::INT.trap do
  udp.leave_group(addr)
  udp.close
end
sleep
