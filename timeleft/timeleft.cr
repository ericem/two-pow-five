# cerner_2^5_2019
require "colorize"
require "http/client"
require "json"
require "file_utils"
force_update = true if ENV.has_key?("REFRESH")
race, sex, survey_year, body = ENV.fetch("RACE", "All Races"), ENV.fetch("SEX", "Both Sexes"), 2014, ""
birth_year, birth_month, birth_day = ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i
cache=Path["~/.cache"].expand
begin
  body = File.open("#{cache}/mortality.json") do |file|
    file.gets
  end
rescue Errno
end
if ! body || force_update
  params = HTTP::Params.encode({"race" => race, "sex" => sex, "year" => survey_year.to_s})
  body = HTTP::Client.get("https://data.cdc.gov/resource/w9j2-ggv5.json?#{params}").body.to_s
  FileUtils.mkdir_p(cache.to_s)
  File.open("#{cache}/mortality.json", "w") do |file|
    file.puts(body)
  end
end
ale = JSON.parse(body).as_a[0]["average_life_expectancy"].as_s.to_f
birthday = Time.local(birth_year,birth_month,birth_day)
years = ale.to_i
days = ((ale - ale.to_i).round(1) * 365).to_i
deathday = birthday.shift(years: years, days: days)
timeleft = (deathday - birthday).days
puts "You will live to be #{ale} years old"
puts "Your death day is #{deathday.day_of_week} #{deathday.to_s("%B")} #{deathday.day} #{deathday.year}"
puts "You have #{timeleft.colorize(:red).toggle(true)} days left"
