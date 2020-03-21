#!/usr/bin/env ruby

module Nbt
  class Compound < Tag
    def children
      return @children if @children
      @children = []
      unparsed = @tag_string.byteslice(base_size..@tag_string.bytesize)
      loop do
        tag = Nbt::parse(unparsed)
        puts tag.inspect
        unparsed = unparsed[tag.size..-1]
        @children << tag
        break if unparsed.length == 0 || tag.type == 'End'
      end
      @children
    end

    def size
      @size ||= children.map(&:size).reduce(:+)
    end

    def inspect
      "#{super}\n#{children.map{ |c| "\t#{c.inspect}" }.join("\n")}"
    end
  end
end
