#!/usr/bin/env ruby

module Nbt
  class String < Tag
    LEN_SIZE = 2 # Short int (16 bits, 2 bytes)

    def length
      @length ||= ::ByteArray.to_i(@tag_string.bytes[base_size..(base_size + LEN_SIZE)])
    end

    def size
      base_size + LEN_SIZE + length
    end

    def name
      @name ||= @tag_string
        .bytes[3..(name_length + 3)]
        .pack('C*')
        .force_encoding('utf-8')
    end

    def payload
      @payload ||= @tag_string
        .bytes[(base_size + LEN_SIZE)..length]
        .pack('C*')
        .force_encoding('utf-8')
    end

    def inspect
      "#{super}, length: #{length}, size: #{size}, payload: #{payload}"
    end
  end
end
