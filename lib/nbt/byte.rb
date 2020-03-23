#!/usr/bin/env ruby

module Nbt
  class Byte < TagNumeric
    def type_size
      1 # integer
    end
  end
end
