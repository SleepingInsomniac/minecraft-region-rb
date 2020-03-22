#!/usr/bin/env ruby

module Nbt
  class IntArray < TagArray
    def length_size
      4 # integer
    end
  end
end
