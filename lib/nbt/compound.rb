#!/usr/bin/env ruby

module Nbt
  class Compound < Tag
    def length
      children.length
    end

    def children
      return @children if @children
      @children = []
      unparsed = @tag_string.byteslice(base_size..@tag_string.bytesize)
      loop do
        tag = Nbt::parse(unparsed)
        unparsed = unparsed.byteslice((tag.size)..unparsed.bytesize)
        @children << tag
        break if tag.type == 'End'
      end
      @children
    end

    def payload
      children
    end

    def size
      @size ||= (base_size + children.map(&:size).reduce(:+))
    end

    def to_h
      super.merge({ length: length, payload: children.map(&:to_h) })
    end

    def inspect
      "#{super} (length: #{length})\n#{children.map{|c| "    #{c.inspect}"}.join("\n")}"
    end
  end
end
