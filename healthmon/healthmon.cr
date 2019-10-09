# cerner_2^5_2019
require "kemal"
require "kemal-basic-auth"
auth = ENV.fetch("AUTH", nil)
error 404 do |env|
  "404: Process not found\n"
end
if auth
  token = auth == "true" ? Random::Secure.urlsafe_base64(10) : auth
  basic_auth "healthmon", token
end
get "/" do |env|
  env.response.content_type = "text/plain"
  {"pids" => "#{`ps -e -o pid=,ucomm= | sort`.chomp}".split("\n")}.to_json
end
get "/:pid" do |env|
  pid, env.response.content_type = env.params.url["pid"], "application/json"
  ps = `ps -o pid= -p #{pid}`
  if $?.success?
    start, stats = `ps -o lstart= -p #{pid}`, `ps -o %cpu=,%mem=,rss=,state= -p #{pid}`.split()
    start_rfc3339 = Time.parse_local(start, "%a %b %e %H:%M:%S %Y").to_rfc3339
    uptime = Time.local - Time.parse_local(start, "%a %b %e %H:%M:%S %Y")
    {"pid" => pid.to_i, "start" => start_rfc3339, "uptime" => "#{uptime.days}d#{uptime.hours}h#{uptime.minutes}m#{uptime.seconds}s", "cpu_pct" => stats[0].to_f, "mem_pct" => stats[1].to_f, "mem_kbytes" => stats[2].to_i}.to_json
  else
    error = {"error" => "Process not found (#{pid})"}.to_json
    halt env, status_code: 404, response: error
  end
end
Kemal.run do |config|
  log "[#{Kemal.config.env}] Enabling basic authentication" if token
  log "[#{Kemal.config.env}] Username is healthmon" if token
  log "[#{Kemal.config.env}] Password is #{token}" if token
end
