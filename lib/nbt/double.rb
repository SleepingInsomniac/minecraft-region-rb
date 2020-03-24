#!/usr/bin/env ruby

module Nbt
  class Double < TagNumeric
    # 8 bytes / 64 bits, signed, big endian, IEEE 754-2008, binary64
    # https://ruby-doc.org/core-2.7.0/Array.html#method-i-pack
    def payload
      return @payload if @payload
      @payload = raw.unpack("G").first.round(16)
      # exp = ::ByteArray.to_i(payload_bytes[1..11])
      # mantissa = ::ByteArray.to_i(payload_bytes[12..-1])
      # mantissa *= -1 if sign
      # @payload = mantissa * 10 ** exp
    end
  end
end
