#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path(File.join(__dir__, 'lib')))

require 'bundler'
Bundler.require

require 'json'
require 'region'

r = Region.new('test_data/r.0.0.mca')

# puts r.locations.first
chunk = r.chunk(r.locations.first)

# puts JSON.pretty_generate(chunk)
# byebug
puts chunk[:nbt].inspect
