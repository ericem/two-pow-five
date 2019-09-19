# cerner_2^5_2019
require "json"
require "file_utils"
force_update = true if ENV.has_key?("REFRESH")
tag1, tag2, nodes = ARGV[0], ARGV[1], [] of String
cache=Path["~/.cache/nodes/#{tag1.tr(":*?\"<>|/!{}[] +&\\","").strip.downcase}"].expand
begin
  File.open("#{cache}/#{tag2.tr(":*?\"<>|/!{}[] +&\\","").strip.downcase}.txt") do |file|
    if (Time.utc - file.info.modification_time) < 1.hour && !force_update
      file.each_line do |line|
        puts line
      end
      exit 0
    end
  end
rescue Errno
end
results = JSON.parse(`knife search node "tags:#{tag1} AND tags:#{tag2}" -F json -a ipaddress`)
results["rows"].as_a.each do |row|
  row.as_h.each do |result|
    name, ip = result[0].to_s, result[1]["ipaddress"].to_s
    nodes << "#{name}"
  end
end
exit 0 if nodes.empty?
FileUtils.mkdir_p(cache.to_s)
File.open("#{cache}/#{tag2.tr(":*?\"<>|/!{}[] +&\\","").strip.downcase}.txt", "w") do |file|
  nodes.sort.each do |node|
    puts node
    file.puts node
  end
end
