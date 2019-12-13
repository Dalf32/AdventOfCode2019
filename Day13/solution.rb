# frozen_string_literal: true

# solution.rb
#
# AUTHOR::  Kyle Mullins

require_relative '../Common/intcode/computer'

module Day13
  def process_input(input_lines)
    input_lines.first.split(',').map(&:to_i)
  end

  class Part1
    include Day13

    def solve(input)
      Intcode::Computer.program(input).run.each_slice(3).map(&:last).count(2)
    end
  end

  class Part2
    include Day13

    def solve(input)
      input[0] = 2
      Intcode::Computer.program(input).run.each_slice(3).map(&:last).count(2)
    end
  end
end
