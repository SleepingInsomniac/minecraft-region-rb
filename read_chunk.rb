#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path(File.join(__dir__, 'lib')))

require 'region'

r = Region.new('test_data/r.0.0.mca')

puts r.locations.first
puts r.chunk(r.locations.first)
