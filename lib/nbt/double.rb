#!/usr/bin/env ruby

module Nbt
  class Double < TagNumeric
    # 8 bytes / 64 bits, signed, big endian, IEEE 754-2008, binary64
    def payload
      return @payload if @payload
      value    = raw_value[1..-1]
      exp      = value[0..11]
      mantissa = value[12..-1]
      mantissa *= -1 if sign
      @payload = mantissa * 10 ** exp
    end
  end
end
