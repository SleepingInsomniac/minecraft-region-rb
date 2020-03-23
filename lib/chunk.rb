#!/usr/bin/env ruby

class Chunk
  attr_reader :offset, :chunk_length, :compression, :nbt

  def initialize(nbt:, offset: nil, byte_offset: nil, chunk_length: nil, compression_type: nil)
    @nbt                 = nbt
    @offset              = offset
    @byte_offset         = byte_offset
    @chunk_length        = chunk_length
    @compression_type    = compression_type
  end

  def to_h
    {
      offset:         @offset,
      byte_offset:    @byte_offset,
      chunk_length:   @chunk_length,
      compression:    @compression_type,
      nbt:            @nbt.to_h,
    }
  end

  def inspect
    "<Chunk: #{@offset} size:#{@chunk_length}>"
  end
end
