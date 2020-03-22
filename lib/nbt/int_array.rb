#!/usr/bin/env ruby

module Nbt
  class IntArray < TagArray
    def length_size
      4 # integer
    end

    def type_size
      4 # byte
    end
  end
end
