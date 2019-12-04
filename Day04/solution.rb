# frozen_string_literal: true

# solution.rb
#
# AUTHOR::  Kyle Mullins

module Day04
  def process_input(input_lines)
    input_lines.first.split('-').map(&:to_i)
  end

  class Part1
    include Day04

    def solve(input)
      Range.new(*input).count do |pass|
        valid = pass == pass.to_s.chars.sort.join.to_i
        valid && pass.to_s.length != pass.to_s.chars.chunk { |c| c }.count
      end
    end
  end

  class Part2
    include Day04

    def solve(input)
      Range.new(*input).count do |pass|
        valid = pass == pass.to_s.chars.sort.join.to_i
        chunks = pass.to_s.chars.chunk { |c| c }
        valid && chunks.select { |ch| ch.last.count == 2 }.any?
      end
    end
  end
end
