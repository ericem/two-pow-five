# cerner_2^5_2019
require "http/client"
require "json"
require "crotp"
require "uri"
struct Info
  include JSON::Serializable
  property ip, port, totp
  def initialize(@ip : String, @port : Int32, @totp : String)
  end
end
getip_uri = ARGV[0]?
key, secret, totp_secret = ENV.fetch("GETIP_KEY", nil), ENV.fetch("GETIP_SECRET", nil), ENV.fetch("GETIP_TOTPSECRET", nil)
if key && secret && totp_secret && getip_uri
  key, secret, totp_secret = key.chomp, secret.chomp, totp_secret.chomp
  uri = URI.parse(getip_uri)
  HTTP::Client.new(uri) do |client|
    client.basic_auth(key, secret)
    response = client.get("/", headers: HTTP::Headers{"Accept" => "application/json"})
    info = Info.from_json(response.body)
    totp = CrOTP::TOTP.new(totp_secret)
    if totp.verify(info.totp)
      puts info.ip
    else
      puts "Error: Received TOTP token #{info.totp} could not be verified"
      exit 1
    end
  end
end
