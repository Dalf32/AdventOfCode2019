# frozen_string_literal: true

# solution.rb
#
# AUTHOR::  Kyle Mullins

require_relative '../Common/intcode/computer'

module Day02
  def process_input(input_lines)
    input_lines.first.split(',').map(&:to_i)
  end

  class Part1
    include Day02

    def solve(input)
      Intcode::Computer.program(input, 12, 2).run

      input[0]
    end
  end

  class Part2
    include Day02

    def solve(input)
      (0..99).each do |noun|
        (0..99).each do |verb|
          memory = input.dup
          Intcode::Computer.program(memory, noun, verb).run

          return 100 * noun + verb if memory[0] == 19_690_720
        end
      end
    end
  end
end
