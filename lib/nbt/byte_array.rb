#!/usr/bin/env ruby

module Nbt
  class ByteArray < TagArray
    def length_size
      1 # in bytes
    end
  end
end
