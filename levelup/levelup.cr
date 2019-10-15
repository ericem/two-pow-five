# cerner_2^5_2019
require "yaml"
struct Config
  include YAML::Serializable
  property last_study, last_review
  def initialize(@last_study : String, @last_review : String)
  end
end
now, cfgdir = Time.local(Time.local.year, Time.local.month, Time.local.day, Time.local.hour, Time.local.minute, Time.local.second), Path["~/.config"].expand
cfgfile="#{cfgdir}/levelup.yml"
if File.exists?(cfgfile)
  conf = File.open(cfgfile) do |file|
    Config.from_yaml(file)
  end
else
  conf = Config.new(now.to_rfc3339, now.to_rfc3339)
  File.open(cfgfile, "w") do |file|
    file.puts(conf.to_yaml)
  end
end
if (now - Time.parse_rfc3339(conf.last_study)) > 1.hour
  print "It's time to study, would you like to study now? [y/n] "
  case gets
  when "y", "Y"
    conf = Config.new(now.to_rfc3339, now.to_rfc3339)
    File.open(cfgfile, "w") do |file|
      file.puts(conf.to_yaml)
    end
    decks = `drill-srs list-decks | awk -F: '{print $1}'`.chomp.split("\n")
    Process.exec("drill-srs", ["study", "#{decks.sample}"]) if decks
  else
  end
end
