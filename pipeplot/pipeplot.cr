# cerner_2^5_2019
stats, interval, title, ytitle, column, fname = Channel(String).new, ENV.fetch("INTERVAL", "3600").to_i, ENV.fetch("TITLE", "Host Metrics"), ENV.fetch("YTITLE", "Data"), ENV.fetch("COLUMN", "2").to_i, ENV.fetch("PNG", "pipeplot")
spawn do
  loop do
    line = gets
    stats.send(line.chomp) if line
  end
end
spawn do
  tlast = nil
  data = File.tempfile("pipeplot")
  loop do
    line = stats.receive()
    tnow = Time.parse_rfc3339(line.split()[0]) unless /^#/.match(line)
    puts line
    STDOUT.flush
    data.puts(line)
    data.flush()
    if tnow && tlast
      if tnow - tlast >= interval.seconds
        Process.new("gnuplot", ["-e", "phi=(1+sqrt(5))/2; width=1440; height=width/phi; set size ratio 1/phi; set autoscale; set xlabel 'Time'; set ylabel '#{ytitle}'; set title '#{title}'; set grid xtics ytics; set yrange [0:*]; set xdata time; set timefmt '%Y-%m-%dT%H:%M:%SZ'; set format x '%H:%M:%S'; set style line 1 linetype 1 linecolor rgb '#5533ddaa'; set term png size width,height; set output '#{fname}-#{tnow.to_unix}.png'; plot '#{data.path}' using 1:#{column} with lines notitle"])
        tlast = tnow
        data.close()
        data = File.tempfile("pipeplot")
      end
    else
      tlast = tnow
    end
    STDOUT.flush
  end
end
sleep
