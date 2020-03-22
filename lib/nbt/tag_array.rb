#!/usr/bin/env ruby

module Nbt
  class TagArray < Tag
    def length_size
      2 # in bytes
    end

    def length
      # Length is an int (4 bytes) after tag name
      @length ||= ::ByteArray.to_i(@tag_string.bytes[base_size..(base_size + (length_size - 1))])
    end

    def size
      base_size + length
    end

    def payload
      @payload ||= @tag_string
        .bytes[(base_size + 1)..(base_size + length)]
        .each_slice(length_size)
        .map{ |bytes| ::ByteArray.to_i(bytes) }
    end

    def inspect
      "#{super} (#{length}) #{payload}"
    end
  end
end
