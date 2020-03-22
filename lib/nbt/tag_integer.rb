#!/usr/bin/env ruby

module Nbt
  class TagInteger < Tag
    def payload
      _size = case type
              when 'Byte'        then 0
              when 'Short'       then 1
              when 'Int'         then 3
              when 'Long'        then 7
              end
      ::ByteArray.to_i(@tag_string.bytes[base_size..(base_size + _size)])
    end

    def inspect
      "#{super} #{payload}"
    end
  end
end
