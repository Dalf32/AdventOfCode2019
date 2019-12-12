# frozen_string_literal: true

# solution.rb
#
# AUTHOR::  Kyle Mullins

require_relative 'moon'

module Day12
  def process_input(input_lines)
    input_lines.map { |triple_str| Moon.new(Triple.from_str(triple_str)) }
  end

  def step(moons)
    moons.combination(2).each do |moon1, moon2|
      moon1.gravitate_to(moon2)
      moon2.gravitate_to(moon1)
    end

    moons.each(&:move)
  end

  class Part1
    include Day12

    def solve(input)
      1000.times { step(input) }
      input.map(&:energy).sum
    end
  end
end
