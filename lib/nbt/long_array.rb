#!/usr/bin/env ruby

module Nbt
  class LongArray < TagArray
    def length_size
      8 # in bytes
    end
  end
end
