#!/usr/bin/env ruby

class ByteArray
  # Parse an array of big endian bytes to one number
  def self.to_i(bytes, size: 8)
    bytes
      .reverse
      .each_with_index
      .reduce(0) do |acc, (byte, shift)|
        acc + (byte << (size * shift))
      end
  end
end
