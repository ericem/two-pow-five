# cerner_2^5_2019
command = ENV["SSH_ORIGINAL_COMMAND"].to_s if ENV.has_key?("SSH_ORIGINAL_COMMAND")
case command
when "ansible"
  puts "Starting ansible environment"
  Process.exec("docker", %w{run -it jumpbox/ansible})
when "chef"
  puts "Starting chef enviroment"
  Process.exec("docker", %w{run -it jumpbox/ansible})
else
  puts "Unknown environment #{command}"
  exit 1
end
