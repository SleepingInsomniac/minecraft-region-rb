#!/usr/bin/env ruby

module Nbt
  class Float < TagNumeric
    def type_size
      4
    end

    # 4 bytes / 32 bits, signed, big endian, IEEE 754-2008, binary32
    def payload
      return @payload if @payload
      value    = raw_value[1..-1]
      exp      = value[0..7]
      mantissa = value[8..-1]
      mantissa *= -1 if sign
      @payload = mantissa * 10 ** exp
    end
  end
end
