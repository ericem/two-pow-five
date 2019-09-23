# cerner_2^5_2019
require "colorize"
streaks_log = ENV.fetch("STREAKS_LOG", "/Users/#{ENV["USER"]}/.local/log/streaks.log")
streaks = [] of Time; File.open(streaks_log) do |file|
  file.each_line do |line|
    streaks << Time.parse_rfc2822(line)
  end
end
today,month,year = Time.local(Time.local.year, Time.local.month, Time.local.day),Time.local.to_s("%B"),Time.local.to_s("%Y")
puts "#{" " * ((20 - (month.size + year.size + 1)) / 2)}#{month} #{year}"
puts "Su Mo Tu We Th Fr Sa"
day = start = today.at_beginning_of_month; dh = {7=>0,1=>1,2=>2,3=>3,4=>4,5=>5,6=>6}
7.times do |d|
  if d < dh[day.day_of_week.value]
    print "   "
  else
    day_color = streaks.find {|t| t.day == day.day && t.month == day.month && t.year == day.year} ? day.to_s("%e").colorize(:green).toggle(true) : day.to_s("%e")
    print "#{day_color} " if day.month == today.month
    day = day + 1.days
  end
  end; puts
4.times do |w|
  [7,1,2,3,4,5,6].each do |d|
    if day.day_of_week.value == d
      day_color = streaks.find {|t| t.day == day.day && t.month == day.month && t.year == day.year} ? day.to_s("%e").colorize(:green).toggle(true) : day.to_s("%e")
      print "#{day_color} " if day.month == today.month
    else
      print "  "
    end
    day = day + 1.days
  end; puts
end
