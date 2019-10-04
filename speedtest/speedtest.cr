# cerner_2^5_2019
require "colorize"
url, timeout = ENV.fetch("SPEEDHOST","http://speedtest.dal01.softlayer.com/downloads/test100.zip"), ENV.fetch("TIMEOUT","10").to_i
write_out = "%{time_namelookup} %{time_connect} %{time_appconnect} %{time_total} %{speed_download} %{http_code}\\n"
curl_cmd, curl_opts = "curl", ["--write-out", "#{write_out}", "--output", "/dev/null", "--show-error", "--connect-timeout", "#{timeout}", "#{url}"]
STDERR.puts "#{curl_cmd} #{curl_opts[0]} '#{curl_opts[1]}' #{curl_opts[2..].join(" ")}" if ENV.has_key?("DEBUG")
now = Time.local
p = Process.run(curl_cmd, curl_opts) do |curl|
  out = curl.output.gets
  data = Tuple(Float64, Float64, Float64, Float64, Float64, Int32)
  if out.is_a?(String)
    vals = out.split()
    data = {vals[0].to_f, vals[1].to_f, vals[2].to_f, vals[3].to_f, vals[4].to_f, vals[5].to_i}
  end
  error = curl.error.gets
  {data, error}
end
if ! $?.success?
  puts "#{now.to_rfc3339} #{$?.exit_code.colorize(:red).toggle(true)} #{"fail".colorize(:red).toggle(true)} #{p[0][5]} #{p[0][0]} #{p[0][1]} #{p[0][2]} #{p[0][3]}, #{p[0][4]}"
  STDERR.puts "#{now.to_rfc3339} #{$?.exit_code} ##{p[1]}" if ENV.has_key?("DEBUG")
else
  http_code = p[0][5]
  if http_code.is_a?(Int32)
    if http_code >= 400 && http_code <= 500
      puts "#{now.to_rfc3339} #{$?.exit_code} #{"error".colorize(:cyan).toggle(true)} #{p[0][5].colorize(:cyan).toggle(true)} #{p[0][0]} #{p[0][1]} #{p[0][2]} #{p[0][3]} #{p[0][4]}"
    else
      mbps = p[0][4].as(Float64) / 125000.0
      STDOUT.puts "#{now.to_rfc3339} #{$?.exit_code} #{"success".colorize(:green).toggle(true)} #{p[0][5].colorize(:green).toggle(true)} #{p[0][0]} #{p[0][1]} #{p[0][2]} #{p[0][3]} #{mbps}" if ENV.has_key?("DEBUG")
      puts "#{mbps.round(2)} mbps"
    end
  end
end
