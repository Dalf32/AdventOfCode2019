# frozen_string_literal: true

# solution.rb
#
# AUTHOR::  Kyle Mullins

require_relative '../Common/intcode/computer'
require_relative 'sparse_expanding_array'

module Day09
  def process_input(input_lines)
    input_lines.first.split(',').map(&:to_i)
  end

  class Part1
    include Day09

    def solve(input)
      memory = SparseExpandingArray.new(input)
      Intcode::Computer.program(memory).run([1]).first
    end
  end

  class Part2
    include Day09

    def solve(input)
      memory = SparseExpandingArray.new(input)
      Intcode::Computer.program(memory).run([2]).first
    end
  end
end
