#!/usr/bin/env ruby

module Nbt
  class Long < TagNumeric
    def type_size
      8 # long
    end
  end
end
