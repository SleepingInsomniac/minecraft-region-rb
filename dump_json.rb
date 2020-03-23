#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path(File.join(__dir__, 'lib')))

require 'bundler'
Bundler.require

require 'json'
require 'region'

r = Region.new('test_data/r.0.0.mca')

# r.locations.each do |loc|
loc = r.locations.first
  chunk = r.chunk(loc)
  puts JSON.pretty_generate(chunk.to_h)
# end
