# cerner_2^5_2019
require "yaml"
struct Hobofile
  include YAML::Serializable
  property image, command
  def initialize(@image : String, @command : String)
  end
end
cmd = ARGV[0]?
case cmd
when "up"
  puts "Container already exists" && exit 0 if File.exists?(".hobo/id")
  hobo = File.open("Hobofile") do |file|
    Hobofile.from_yaml(file)
  end
  command = hobo.command.nil? ? "" : hobo.command
  id = `docker run -itd -v $PWD:/hobo #{hobo.image} #{command}`.chomp
  Dir.mkdir_p(".hobo") unless Dir.exists?(".hobo")
  idfile = File.open(".hobo/id", "w")
  idfile.puts(id)
  idfile.close
when "status"
  id = File.open(".hobo/id").gets() if File.exists?(".hobo/id")
  Process.exec("docker", ["container", "ps", "--filter", "id=#{id}"]) if id
when "login"
  id = File.open(".hobo/id").gets() if File.exists?(".hobo/id")
  Process.exec("docker", ["exec", "-it", "#{id}", "/bin/sh"]) if id
when "destroy"
  id = File.open(".hobo/id").gets() if File.exists?(".hobo/id")
  `docker stop #{id} && docker rm #{id}` if id
  File.delete(".hobo/id") if id
else
  STDERR.puts "Usage: hobo up|status|login|destroy"
  exit 1
end
