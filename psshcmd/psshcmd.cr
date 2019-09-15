# cerner_2^5_2019
require "ssh2"

command = ARGV.join(' ')
output = Channel(NamedTuple(host: String, status: Int32)).new
hosts = Array(String).new
STDIN.each_line do |line|
  hosts << line.strip unless line.empty?
end

hosts.each do |host|
  spawn do
    SSH2::Session.open(host) do |session|
      if ENV.has_key? "SSH_PUBKEY"
        session.login_with_pubkey(ENV["SSH_USER"].chomp, ENV["SSH_PRIVKEY"].chomp, ENV["SSH_PUBKEY"].chomp, ENV["SSH_KEYPASS"].chomp)
      else
        session.login(ENV["SSH_USER"].chomp, ENV["SSH_PASS"].chomp)
      end
      session.open_session do |channel|
        channel.command(command)
        line = channel.gets_to_end
        channel.wait_closed
        output.send({host: host, status: channel.exit_status})
      end
    end
  end

end

hosts.size.times do
  result = output.receive
  puts "#{result[:host]} #{result[:status]}"
end
