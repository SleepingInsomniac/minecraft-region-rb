#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path(File.join(__dir__, 'lib')))

require 'bundler'
Bundler.require

require 'json'
require 'region'

r = Region.new('test_data/r.0.0.mca')

chunk = r.chunk(r.locations.first)
puts chunk.nbt.inspect
# puts chunk.nbt.tag_string.bytes[0..40].map{|b| b.to_s(16) }
# puts chunk.nbt.tag_string.bytes.map{|b| b.to_s(16)}.join('')
