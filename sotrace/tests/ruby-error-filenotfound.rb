#!/usr/bin/env ruby


File.open('this-file-should-not-exist-orlly??.txt') do |f|
  while line = f.gets
    puts line
  end
end
