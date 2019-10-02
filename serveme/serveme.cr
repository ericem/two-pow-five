# cerner_2^5_2019
require "kemal"
require "kemal-basic-auth"
auth, ip = ENV.fetch("AUTH", nil), `netstat -rn -f inet | grep default | awk '{print $6}' | xargs -I {} ifconfig {} inet | awk '/inet/ {print $2}'`.chomp
error 404 do |env|
  "404: File not found\n"
end
if auth
  token = auth == "true" ? Random::Secure.urlsafe_base64(10) : auth
  basic_auth "serveme", token
end
ls = Dir.glob(["*"], match_hidden = false)
get "/" do |env|
  env.response.content_type = "text/plain"
  "#{ls.join("\n")}\n"
end
get "/:file" do |env|
  file = env.params.url["file"]
  if ls.includes?(file) && ! file.includes?("/")
    send_file env, "./#{file}"
  else
    halt env, status_code: 404, response: "404: File not found (#{file})\n"
  end
end
`echo 'curl#{" -u serveme:" if token}#{token if token} http://#{ip}:#{Kemal.config.port}/' | pbcopy`
Kemal.run do |config|
  log "[#{Kemal.config.env}] Enabling basic authentication" if token
  log "[#{Kemal.config.env}] Username is serveme" if token
  log "[#{Kemal.config.env}] Password is #{token}" if token
  log "[#{Kemal.config.env}] curl command copied to clipboard"
end
