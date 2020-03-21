#!/usr/bin/env ruby

module Nbt
  class End < Tag
    def base_size
      1
    end

    def inspect
      "type: #{type}"
    end
  end
end
