# cerner_2^5_2019
require "baked_file_system"
require "http/client"
chan, pid, flow_url = Channel(String).new, ARGV[0]?, ENV.fetch("FLOWURL", nil)
class FileStorage
  extend BakedFileSystem
  bake_folder "bakedfs"
end
bindir = Path["~/.local/bin"].expand
bin = bindir/"killsnoop.py"
Dir.mkdir_p(bindir.to_s) unless Dir.exists?(bindir.to_s)
src = FileStorage.get("killsnoop.py")
dst = File.open(bin, "w")
IO.copy src, dst
src.close
dst.close
File.chmod(bin, 0o755)
num = 0
process = Process.new("sudo", [bin.to_s], output: Process::Redirect::Pipe, error: Process::Redirect::Pipe, shell: true)
loop do
  line = process.output.gets
  if line && /#{pid}/.match(line)
    fields = line.split() # PID    COMM             SIG  TPID   RESULT
    puts msg = "Process #{pid} was killed by #{fields[0]} (#{fields[1]}) with signal #{fields[2]}"
    if flow_url
      body = "{\"message\": \"#{msg}\"}"
      puts "Sending notification"
      response = HTTP::Client.post("#{ENV.fetch("FLOWURL")}", headers: HTTP::Headers{"Content-Type" => "application/json", "Accept" => "application/json"}, body: body )
    end
    exit 0
    end
end
