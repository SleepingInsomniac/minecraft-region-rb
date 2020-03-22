#!/usr/bin/env ruby

module Nbt
  class String < TagArray
    def payload
      @payload ||= @tag_string
        .bytes[(base_size + 2)..(base_size + 1 + length)]
        .pack('C*')
        .force_encoding('utf-8')
    end

    def size
      base_size + length_size + length
    end
  end
end
