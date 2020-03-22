#!/usr/bin/env ruby

module Nbt
  class LongArray < TagArray
    # Size of the number that describes payloads
    def length_size
      4
    end

    # Size of every payload item
    def type_size
      8 # byte
    end
  end
end
