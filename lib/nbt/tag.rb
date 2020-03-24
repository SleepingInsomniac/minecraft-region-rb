#!/usr/bin/env ruby

require 'byte_array'

module Nbt
  # The first byte in a tag is the tag type (ID)
  # followed by a two byte big-endian unsigned integer for the length of the name
  # then the name as a string in UTF-8 format
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

    attr_reader :tag_string

    # Via unpack:
    #   C # 8 bit, tag_id
    #   S # 16 bit, short unsigned name_length

    def initialize(tag_string)
      @tag_string = tag_string
      # puts "Init tag: #{type}:#{name}"
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
        .byteslice(3..(name_length + 2))
        .force_encoding('utf-8')
        .strip
    end

    def length_size
      0
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

    def payload_bytes
      @payload_bytes ||= raw.bytes[(base_size + length_size)..-1]
    end

    def payload
      @payload ||= payload_bytes
    end

    def inspect
      "<#{type}:#{name&.strip}>"
    end

    def to_h
      {
        type: type,
        name: name,
        payload: payload
      }
    end

    def name_length
      return 0 if type == 'End'
      @name_length ||= @tag_string.byteslice(1..2).unpack("S>").first
    end

    def raw
      @tag_string = @tag_string.byteslice(0..(size - 1))
    end
  end
end
