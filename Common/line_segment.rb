# frozen_string_literal: true

# Line
#
# AUTHOR::  Kyle Mullins

# NOTE: Only fully supports horizontal and vertical segments
class LineSegment
  attr_reader :a, :b

  def initialize(a, b)
    @a = a
    @b = b
  end

  def vertical?
    @a.x == @b.x
  end

  def horizontal?
    @a.y == @b.y
  end

  def x_range
    Range.new(*[@a.x, @b.x].sort)
  end

  def y_range
    Range.new(*[@a.y, @b.y].sort)
  end

  def length
    @a.distance_from(@b)
  end

  def intersects?(other_line)
    if vertical?
      return false if other_line.vertical?

      y_range.include?(other_line.a.y) && other_line.x_range.include?(@a.x)
    else
      return false if other_line.horizontal?

      x_range.include?(other_line.a.x) && other_line.y_range.include?(@a.y)
    end
  end

  def intersection(other_line)
    vertical? ? Point[@a.x, other_line.a.y] : Point[other_line.a.x, @a.y]
  end

  def includes?(point)
    return @a.x == point.x && y_range.include?(point.y) if vertical?

    @a.y == point.y && x_range.include?(point.x)
  end

  def to_s
    "#{@a}->#{@b}"
  end
end
