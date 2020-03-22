#!/usr/bin/env ruby

module Nbt
  class String < TagArray
    # Size of the number that describes payloads
    def length_size
      2
    end

    # Size of every payload item
    def type_size
      1 # byte
    end

    def payload
      @payload ||= payload_bytes
        .pack('C*')
        .force_encoding('utf-8')
    end
  end
end
