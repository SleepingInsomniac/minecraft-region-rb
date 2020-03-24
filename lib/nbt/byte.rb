#!/usr/bin/env ruby

module Nbt
  # 01               => Byte
  # 00 04            => size of name
  # 62 79 74 65      => "byte"
  # FF               => value
  class Byte < TagNumeric
    def type_size
      1
    end
  end
end
