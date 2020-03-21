#!/usr/bin/env ruby

require 'byte_array'

module Nbt
  class Tag
    TAG_TYPES = {
      0  => 'End',
      1  => 'Byte',
      2  => 'Short',
      3  => 'Int',
      4  => 'Long',
      5  => 'Float',
      6  => 'Double',
      7  => 'Byte_Array',
      8  => 'String',
      9  => 'List',
      10 => 'Compound',
      11 => 'Int_Array',
      12 => 'Long_Array',
    }

    def initialize(tag_string)
      @tag_string = tag_string
    end

    def parse
      Nbt::parse(@tag_string)
    end

    def type_id
      @tag_string.bytes[0]
    end

    def type
      TAG_TYPES[type_id]
    end

    def name
      return nil if type == 'End'
      @name ||= @tag_string
        .bytes[3..(name_length + 3)]
        .pack('C*')
        .force_encoding('utf-8')
    end

    def base_size
      3 + name_length
    end

    # Size in bytes
    def size
      _size = case type
              when 'End'         then 0 # No name size, no name
              when 'Byte'        then 1
              when 'Short'       then 2
              when 'Int'         then 4
              when 'Long'        then 8
              when 'Float'       then 4
              when 'Double'      then 8
              else
                raise "Undefined size for #{type}"
              end
      _size + base_size
    end

    def inspect
      "name: #{name&.strip}, type: #{type}"
    end

    private

    def name_length
      return 0 if type == 'End'
      @name_length ||= ::ByteArray.to_i(@tag_string.bytes[1..2])
    end
  end
end
