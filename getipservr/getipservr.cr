# cerner_2^5_2019
require "kemal"
require "kemal-basic-auth"
require "crotp"
cmd = ARGV[0]?
case cmd
when "secret"
  puts Random::Secure.urlsafe_base64(20)
else
  key, secret, totp_secret = ENV.fetch("GETIP_KEY", nil), ENV.fetch("GETIP_SECRET", nil), ENV.fetch("GETIP_TOTPSECRET", nil)
  if key && secret && totp_secret
    totp = CrOTP::TOTP.new(totp_secret)
    error 404 do |env|
      env.response.content_type = "application/json"
      body = {:code => 404, :message => "Resource Not found"}
      body.to_json
    end
    basic_auth key, secret
    get "/" do |env|
      env.response.content_type = "application/json"
      ip_port = env.request.remote_address.to_s.split(":")
      body = {:ip => ip_port[0], :port => ip_port[1].to_i, :totp => totp.generate()}
      body.to_json
    end
    Kemal.run
  else
    puts "Usage: getipserver <secret>"
    exit 1
  end
end
