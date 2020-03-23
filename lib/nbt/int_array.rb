#!/usr/bin/env ruby

module Nbt
  class IntArray < TagArray
    def length_size
      4 # integer
    end

    def type_size
      4 # integer
    end

    def payload
      @payload ||= payload_bytes
        .each_slice(type_size)
        .map do |bytes|
          # 3  => 'Int'
          nbt_string = [3, 0, 0].concat(bytes).pack('C*')
          Nbt::parse(nbt_string)
        end
    end

    def to_h
      super.merge({ payload: payload.map(&:to_h) })
   end
  end
end
