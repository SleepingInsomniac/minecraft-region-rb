#!/usr/bin/env ruby

module Nbt
  class Short < TagNumeric
    def type_size
      2 # short
    end
  end
end
