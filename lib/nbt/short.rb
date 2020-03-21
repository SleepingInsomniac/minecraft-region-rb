#!/usr/bin/env ruby

module Nbt
  class Short < Tag
    def payload
      ::ByteArray.to_i(@tag_string.bytes[base_size..(base_size + 16)])
    end
  end
end
