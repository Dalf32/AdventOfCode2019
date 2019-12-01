# frozen_string_literal: true

# solution.rb
#
# AUTHOR::  Kyle Mullins

module Day01
  def process_input(input_lines)
    input_lines.map(&:to_i)
  end

  class Part1
    include Day01

    def solve(input)
      input.map { |mass| (mass / 3) - 2 }.sum
    end
  end

  class Part2
    include Day01

    def solve(input)
      input.map { |mass| calc_fuel(mass) }.sum
    end

    def calc_fuel(mass)
      fuel = (mass / 3) - 2
      return 0 unless fuel.positive?

      fuel + calc_fuel(fuel)
    end
  end
end
