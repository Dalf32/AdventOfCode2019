# frozen_string_literal: true

# solution.rb
#
# AUTHOR::  Kyle Mullins

require_relative '../Common/intcode/computer'

module Day05
  def process_input(input_lines)
    input_lines.first.split(',').map(&:to_i)
  end

  class Part1
    include Day05

    def solve(input)
      Intcode::Computer.program(input).run([1]).last
    end
  end

  class Part2
    include Day05

    def solve(input)
      Intcode::Computer.program(input).run([5]).last
    end
  end
end
