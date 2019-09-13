# cerner_2^5_2019
require "colorize"
require "html"
require "http/client"
require "json"

def make_url(title : String, tags : Array) : String
  server = "https://api.stackexchange.com/2.2"
  params = HTTP::Params.encode({"title" => title, "tagged" => tags.join(";")})
  query = "/search/advanced?order=desc&sort=activity&pagesize=10&site=stackoverflow&#{params}"
  server + query
end

lang, command, options = ARGV.shift, ARGV.shift, ARGV
errors = Array(String).new
process = Process.new(command, options, output: Process::Redirect::Pipe, error: Process::Redirect::Pipe)

puts process.output.gets_to_end()
process.error.each_line do |line|
  errors << line.rstrip
end

unless process.wait.success?
  puts "#{errors.join('\n').colorize(:red).toggle(true)}\n\n"
  error = /\((.*)\)/.match(errors.shift).try &.[1]
  if error.is_a?(String)
    puts "Looking up Error on Stackoverflow...\n\n"
    response = HTTP::Client.get(make_url(error, [lang]))
    JSON.parse(response.body)["items"].as_a.each do |item|
      puts "#{HTML.unescape(item["title"].to_s).colorize(:green).toggle(true)}\n  #{item["link"].to_s.colorize(:cyan).toggle(true)}\n\n"
    end
  end
end


