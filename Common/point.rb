# frozen_string_literal: true

##
# point.rb
#
# AUTHOR::  Kyle Mullins
##

class Point
  attr_reader :x, :y

  def self.[](x, y)
    Point.new(x, y)
  end

  def initialize(x, y)
    @x = x
    @y = y
  end

  def distance
    @x.abs + @y.abs
  end

  def manhattan_distance(other_point)
    (@x - other_point.x).abs + (@y - other_point.y).abs
  end

  def distance_from(other_point)
    Math.sqrt((other_point.x - @x)**2 + (other_point.y - @y)**2).to_i
  end

  def in_bounds?(min, max)
    @x.between?(min, max) && @y.between?(min, max)
  end

  def inside?(top_left, bottom_right)
    @x.between?(top_left.x, bottom_right.x) &&
      @y.between?(top_left.y, bottom_right.y)
  end

  def +(other)
    Point.new(@x + other.x, @y + other.y)
  end

  def eql?(other)
    @x == other.x && @y == other.y
  end

  def ==(other)
    eql?(other)
  end

  def to_s
    "(#{@x}, #{@y})"
  end

  def hash
    to_s.hash
  end
end
