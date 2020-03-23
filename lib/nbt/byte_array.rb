#!/usr/bin/env ruby

module Nbt
  class ByteArray < TagArray
    def length_size
      4 # integer
    end

    def type_size
      1 # byte
    end
  end
end
