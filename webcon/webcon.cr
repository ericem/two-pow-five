# cerner_2^5_2019
require "colorize"
require "socket"
command = if ARGV.size > 0
            ARGV[0]
          else
            "start"
          end
case command
when "receive"
  udp = UDPSocket.new(Socket::Family::INET)
  udp.bind("0.0.0.0", 6666)
  spawn do
    loop do
      message, client_addr = udp.receive
      t=Time.utc
      puts "#{Time.utc(t.year,t.month,t.day,t.hour,t.minute,t.second).to_rfc3339.colorize(:blue).toggle(true)} #{client_addr.address.colorize(:yellow).toggle(true)} #{message.colorize(:green).toggle(true)}"
    end
  end
when "start"
  args = "-s SIGINT -p #{ENV.fetch("WEBCON_PORT", "8888")} webcon receive"
  Process.exec("ttyd", args.split(" "))
end
sleep
