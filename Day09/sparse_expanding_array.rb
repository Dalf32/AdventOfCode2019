# frozen_string_literal: true

# SparseExpandingArray
#
# AUTHOR::  Kyle Mullins

class SparseExpandingArray < Array
  def initialize(base_array)
    super(base_array)
    @expansion = Hash.new(0)
  end

  def [](index)
    return super if index.is_a?(Range)
    return super if (0..length).include?(index)

    @expansion[index]
  end

  def []=(index, value)
    (0..length).include?(index) ? super : @expansion[index] = value
  end
end
