# cerner_2^5_2019
require "colorize"
url, timeout = ARGV[0], ENV.fetch("TIMEOUT","10").to_i
write_out = "%{time_namelookup} %{time_connect} %{time_appconnect} %{time_total} %{http_code}\\n"
curl_cmd, curl_opts = "curl", ["--write-out", "#{write_out}", "--output", "/dev/null", "--show-error", "--connect-timeout", "#{timeout}", "--head", "#{url}"]
STDERR.puts "#{curl_cmd} #{curl_opts[0]} '#{curl_opts[1]}' #{curl_opts[2..].join(" ")}" if ENV.has_key?("DEBUG")
while true
  now = Time.local
  p = Process.run(curl_cmd, curl_opts) do |curl|
    out = curl.output.gets
    data = Tuple(Float64, Float64, Float64, Float64, Int32)
    if out.is_a?(String)
      vals = out.split()
      data = {vals[0].to_f, vals[1].to_f, vals[2].to_f, vals[3].to_f, vals[4].to_i}
    end
    error = curl.error.gets
    {data, error}
  end
  if ! $?.success?
    puts "#{now.to_rfc3339} #{$?.exit_code.colorize(:red).toggle(true)} #{"fail".colorize(:red).toggle(true)} #{p[0][4]} #{p[0][0]} #{p[0][1]} #{p[0][2]} #{p[0][3]}"
    STDERR.puts "#{now.to_rfc3339} #{$?.exit_code} ##{p[1]}" if ENV.has_key?("DEBUG")
  else
    http_code = p[0][4]
    if http_code.is_a?(Int32)
      if http_code >= 400 && http_code <= 500
        puts "#{now.to_rfc3339} #{$?.exit_code} #{"error".colorize(:cyan).toggle(true)} #{p[0][4].colorize(:cyan).toggle(true)} #{p[0][0]} #{p[0][2]} #{p[0][2]} #{p[0][3]}"
      else
        STDOUT.puts "#{now.to_rfc3339} #{$?.exit_code} #{"success".colorize(:green).toggle(true)} #{p[0][4].colorize(:green).toggle(true)} #{p[0][0]} #{p[0][1]} #{p[0][2]} #{p[0][3]}"
      end
    end
  end
  sleep ENV.fetch("SLEEP", "60").to_i
end
