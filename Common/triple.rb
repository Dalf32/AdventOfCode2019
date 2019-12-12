# frozen_string_literal: true

# Triple
#
# AUTHOR::  Kyle Mullins

class Triple
  attr_reader :x, :y, :z

  def self.from_str(triple_str)
    coords = triple_str[1..-2].split(', ').map { |c| c.split('=').last.to_i }
    Triple[*coords]
  end

  def self.[](x, y, z)
    Triple.new(x: x, y: y, z: z)
  end

  def initialize(x: 0, y: 0, z: 0)
    @x = x
    @y = y
    @z = z
  end

  def distance
    [@x, @y, @z].map(&:abs).sum
  end

  def +(other)
    return Triple[@x + other, @y + other, @z + other] if other.is_a?(Numeric)

    Triple[@x + other.x, @y + other.y, @z + other.z]
  end

  def *(other)
    return Triple[@x * other, @y * other, @z * other] if other.is_a?(Numeric)

    Triple[@x * other.x, @y * other.y, @z * other.z]
  end

  def eql?(other)
    @x == other.x && @y == other.y && @z == other.z
  end

  def ==(other)
    eql?(other)
  end

  def to_s
    "<x=#{@x}, y=#{@y}, z=#{@z}>"
  end

  def hash
    to_s.hash
  end
end
