#!/usr/bin/env ruby

require 'nbt/tag'
require 'nbt/tag_integer'
require 'nbt/tag_array'

require 'nbt/end'
require 'nbt/byte'
require 'nbt/short'
require 'nbt/int'
require 'nbt/long'
require 'nbt/float'
require 'nbt/double'
require 'nbt/byte_array'
require 'nbt/string'
require 'nbt/list'
require 'nbt/compound'
require 'nbt/int_array'
require 'nbt/long_array'

module Nbt
  def self.parse(string)
    case Nbt::Tag::TAG_TYPES[string.bytes[0]]
    when 'End'         then Nbt::End.new(string)
    when 'Byte'        then Nbt::Byte.new(string)
    when 'Short'       then Nbt::Short.new(string)
    when 'Int'         then Nbt::Int.new(string)
    when 'Long'        then Nbt::Long.new(string)
    when 'Float'       then Nbt::Float.new(string)
    when 'Double'      then Nbt::Double.new(string)
    when 'Byte_Array'  then Nbt::ByteArray.new(string)
    when 'String'      then Nbt::String.new(string)
    when 'List'        then Nbt::List.new(string)
    when 'Compound'    then Nbt::Compound.new(string)
    when 'Int_Array'   then Nbt::IntArray.new(string)
    when 'Long_Array'  then Nbt::LongArray.new(string)
    end
  end
end
