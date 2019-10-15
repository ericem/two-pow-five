# cerner_2^5_2019
require "http/client"
require "json"
struct Stat
  include JSON::Serializable
  property pid, start, uptime, cpu_pct, mem_pct, mem_kbytes
  def initialize(@pid : Int32, @start : String, @uptime : String, @cpu_pct : Float64, @mem_pct : Float64, @mem_kbytes : Int32)
  end
end
stats, healthurl, sleep_sec, alert, bell, header = Channel(Stat).new, ARGV[0], ENV.fetch("SLEEP", "60").to_i, ENV.fetch("ALERT", nil), "\a", ENV.fetch("HEADER", nil)
spawn do
  loop do
    response = HTTP::Client.get "#{healthurl}"
    case response.status_code
    when 200
      stats.send(Stat.from_json(response.body))
    when 404
      STDERR.puts "Error: the process does not exist or has already exited.#{bell if alert}"
      exit 1
    end
    sleep sleep_sec
  end
end
spawn do
  puts "#Time PID Start Uptime CPU_pct Mem_pct Mem_kbytes" if header
  STDOUT.flush
  loop do
    stat = stats.receive
    now = Time.local(Time.local.year, Time.local.month, Time.local.day, Time.local.hour, Time.local.minute, Time.local.second)
    puts "#{now.to_rfc3339} #{stat.pid} #{stat.start} #{stat.uptime} #{stat.cpu_pct} #{stat.mem_pct} #{stat.mem_kbytes}"
    STDOUT.flush
  end
end
sleep
