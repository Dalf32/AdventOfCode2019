# frozen_string_literal: true

# solution.rb
#
# AUTHOR::  Kyle Mullins

require_relative 'orbit'

module Day06
  def process_input(input_lines)
    orbit_strs = input_lines.map { |o| o.split(')') }
    orbit_strs.map(&:last).map { |o| [o, Orbit.new(o)] }.to_h.tap do |objects|
      orbit_strs.each { |orbit, obj| objects[obj].orbits(objects[orbit]) }
    end
  end

  class Part1
    include Day06

    def solve(input)
      input.values.map(&:orbit_count).sum
    end
  end

  class Part2
    include Day06

    def solve(input)
      start_obj_orbits = input['YOU'].orbit_list
      end_obj_orbits = input['SAN'].orbit_list

      meet_index = start_obj_orbits.map(&:name)
                                   .zip(end_obj_orbits.map(&:name))
                                   .find_index { |a, b| a != b }

      start_obj_orbits[meet_index..-1].count +
        end_obj_orbits[meet_index..-1].count
    end
  end
end
