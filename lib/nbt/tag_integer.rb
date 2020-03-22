#!/usr/bin/env ruby

module Nbt
  class TagInteger < Tag
    def payload
      @payload ||= ::ByteArray.to_i(payload_bytes)
    end

    def inspect
      "#{super} #{payload}"
    end
  end
end
