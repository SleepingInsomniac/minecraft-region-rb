#!/usr/bin/env ruby

module Nbt
  class TagNumeric < Tag
    def type_size
      4 # integer
    end

    def payload
      return @payload if @payload
      value = raw_value[1..-1]
      value *= -1 if sign
      @payload = value
    end

    def raw_value
      @raw_value ||= ::ByteArray.to_i(payload_bytes)
    end

    # Negative if 1
    def sign
      # get the bit that denotes sign
      raw_value[(4 * type_size) - 1] > 0
    end

    def inspect
      "#{super} #{payload}"
    end
  end
end
