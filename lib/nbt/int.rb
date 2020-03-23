#!/usr/bin/env ruby

module Nbt
  class Int < TagNumeric
    def type_size
      4 # integer
    end
  end
end
