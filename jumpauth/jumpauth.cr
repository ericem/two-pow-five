# cerner_2^5_2019
require "redis"
redis = Redis.new
command = ARGV[0]
case command
when "set"
  user, key = ARGV[1], ARGV[2]
  redis.multi do |multi|
    multi.set("user/#{user}", key)
    multi.set("user/#{user}/status", "locked")
  end
when "get"
  user = ARGV[1]
  exit 0 if redis.get("user/#{user}/status") == "locked"
  puts redis.get("user/#{user}")
when "del"
  user = ARGV[1]
  redis.multi do |multi|
    multi.del("user/#{user}")
    multi.del("user/#{user}/status")
  end
when "lock"
  user = ARGV[1]
    redis.set("user/#{user}/status", "locked")
when "unlock"
  user = ARGV[1]
    redis.set("user/#{user}/status", "unlocked")
else
  puts "Unkown command"; exit 1
end
