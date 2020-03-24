#!/usr/bin/env ruby

module Nbt
  class Float < TagNumeric
    def type_size
      4
    end

    # 4 bytes / 32 bits, signed, big endian, IEEE 754-2008, binary32
    def payload
      return @payload if @payload
      @payload = raw.unpack("g").first.round(9)
      # exp = ::ByteArray.to_i(payload_bytes[1..8])
      # mantissa = ::ByteArray.to_i(payload_bytes[9..-1])
      # mantissa *= -1 if sign
      # @payload = mantissa * 10 ** exp
    end
  end
end

