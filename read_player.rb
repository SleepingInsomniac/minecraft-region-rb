#!/usr/bin/env ruby
# https://stackoverflow.com/questions/19120676/how-to-detect-type-of-compression-used-on-the-file-if-no-file-extension-is-spe

$LOAD_PATH.unshift(File.expand_path(File.join(__dir__, 'lib')))

require 'bundler'
Bundler.require

require 'json'
require 'zlib'

require 'nbt'

player_dat_path = File.join(__dir__, 'test_data', 'c9df9c7d-8d56-4231-a6a0-e84827fa24de.dat')

# 0x1f, 0x8b, 0x08

file = File.open(player_dat_path, 'rb')
zip_header = Array.new(3) { file.readbyte }
file.rewind

data = if zip_header == [0x1f, 0x8b, 0x08]
  # "Gzip"
  file.close
  Zlib::GzipReader.open(player_dat_path) { |f| f.read }
else
  file.read
  file.close
end

player = Nbt::parse(data)

# puts player.inspect
puts JSON.pretty_generate(player.to_h)
