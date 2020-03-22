#!/usr/bin/env ruby

module Nbt
  class TagArray < Tag
    def length_size
      2 # in bytes
    end

    def type_size
      1 # byte
    end

    def length
      # Length is an integer of (length_size) after tag name
      @length ||= ::ByteArray.to_i(@tag_string.bytes[base_size..(base_size + (length_size - 1))])
    end

    def size
      base_size + length_size + (type_size * length)
    end

    def inspect
      "#{super} (#{length}) #{payload}"
    end
  end
end
