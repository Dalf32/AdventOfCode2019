# frozen_string_literal: true

# solution.rb
#
# AUTHOR::  Kyle Mullins

module Day08
  def process_input(input_lines)
    input_lines.first.chars.map(&:to_i)
  end

  class Part1
    include Day08

    def solve(input)
      layers = input.each_slice(25 * 6)
      min_layer = layers.min_by { |layer| layer.count(0) }
      min_layer.count(1) * min_layer.count(2)
    end
  end

  class Part2
    include Day08

    def solve(input)
      layers = input.each_slice(25 * 6)
      final_img = layers.first.count.times.map do |pixel|
        layers.map { |layer| layer[pixel] }.find { |p| p != 2 }
      end
      "\n" + final_img.each_slice(25).map { |p| p.join(' ') }.join("\n")
    end
  end
end
