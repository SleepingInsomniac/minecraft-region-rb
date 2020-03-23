#!/usr/bin/env ruby

require 'date'
require 'zlib'
require 'chunk'
require 'nbt'
require 'byte_array'

class Region
  L_BYTES = 0..4095                 # Location Bytes
  T_BYTES = 4096..8191              # TimeStamp Bytes
  C_BYTES = 8192                    # Chunks and unused space

  def initialize(file_path)
    @file_path = file_path
  end

  # Parse locations of chunks
  # Offset: bytes 0 - 2
  # Sectors: byte 3
  # Empty offset, is an empty chunk
  def locations
    @locations ||= bytes(L_BYTES).each_slice(4).map do |loc_bytes|
      {
        offset: ByteArray.to_i(loc_bytes[0..2]),
        sector_count: loc_bytes[3]
      }
    end.reject{ |l| l[:offset] == 0 }
  end

  # Timestamps are 4 bytes
  # read with Time#at
  def timestamps
    @timestamps ||= bytes[T_BYTES].each_slice(4).map do |t_bytes|
      ByteArray.to_i(t_bytes)
    end.reject{ |t| t == 0 }
  end

  # | 0 -3              | 4                | 5...                             |
  # | length (in bytes) | compression type | compressed data (length-1 bytes) |
  # Compression types: "GZip (RFC1952)" : 1
  #                    "Zlib (RFC1950)" : 2
  def chunk(location)
    offset = C_BYTES + location[:offset]
    offset = location[:offset] * (1024 * 4) # 4KiB
    chunk_length = ByteArray.to_i(bytes(offset..(offset + 3)))
    compression_type = bytes(offset + 4) == [1] ? :gzip : :zlib
    compressed_nbt = chars((offset + 5)..(offset + 5 + chunk_length))
    raise "Can't uncompress chunk in GZip format" if compression_type == :gzip
    return nil if offset == 0 # Not created
    Chunk.new(
      nbt: Nbt::parse(Zlib::Inflate.inflate(compressed_nbt)),
      offset: location[:offset],
      byte_offset: offset,
      chunk_length: chunk_length,
      compression_type: compression_type,
    )
  end

  private # ===============================================

  # Don't load everything into memory, that's crazy
  def bytes(range)
    range = (range..range) if range.is_a?(Integer)
    file =  File.open(@file_path, 'rb')
    file.pos = range.first
    _bytes = []
    range.size.times do
      _bytes << file.readbyte
    end
    file.close
    _bytes
  end

  # Load up some chars from the file
  def chars(range)
    range = (range..range) if range.is_a?(Integer)
    file =  File.open(@file_path, 'r')
    file.pos = range.first
    _chars = ""
    loop do
      _chars << file.readchar
      break if file.pos >= range.last
    end
    file.close
    _chars
  end
end
