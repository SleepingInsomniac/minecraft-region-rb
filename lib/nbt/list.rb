#!/usr/bin/env ruby

module Nbt
  class List < Tag
    def list_type_id
      @tag_string.bytes[base_size]
    end

    def list_type
      TAG_TYPES[list_type_id]
    end

    def length
      # Length is an integer of (length_size) after tag name, after tags id
      @length ||= ::ByteArray.to_i(@tag_string.bytes[(base_size + 1)..(base_size + 4)])
    end

    def children
      return @children if @children
      @children = []
      unparsed = @tag_string.byteslice((base_size + 5)..@tag_string.bytesize)

      # Create a header based on the list type, with no name
      c_header = [list_type_id, 0, 0].pack('C*')

      length.times do
        # Just inject the type_id, with no name on every item
        unparsed = c_header + unparsed
        tag = Nbt::parse(unparsed)
        unparsed = unparsed.byteslice((tag.size)..unparsed.bytesize)
        @children << tag
      end

      @children
    end

    def payload
      children
    end

    def to_h
      super.merge({ payload: children.map(&:to_h) })
    end

    def size
      # base_size + 1 byte (ids) + 4 bytes (length) + children sizes
      children_size = if children.any?
                        # -3, since 1 byte for type, 2 for name length which is 0
                        children.map{ |c| c.size - 3 }.reduce(:+)
                      else
                        0
                      end
      base_size + 5 + children_size
    end

    def inspect
      "#{super} (length: #{length})\n#{children.map{|c| "    #{c.inspect}"}.join("\n")}"
    end
  end
end
