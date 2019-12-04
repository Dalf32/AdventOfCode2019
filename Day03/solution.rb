# frozen_string_literal: true

# solution.rb
#
# AUTHOR::  Kyle Mullins

require_relative '../Common/point'
require_relative '../Common/line_segment'

module Day03
  def process_input(input_lines)
    input_lines.map { |path| path.split(',') }
  end

  def map_wire_points(path)
    wire_pts = [Point.new(0, 0)]

    path.each do |turn|
      len = turn[1..-1].to_i

      case turn[0]
      when 'L'
        wire_pts << wire_pts.last + Point[-1 * len, 0]
      when 'R'
        wire_pts << wire_pts.last + Point[len, 0]
      when 'U'
        wire_pts << wire_pts.last + Point[0, len]
      when 'D'
        wire_pts << wire_pts.last + Point[0, -1 * len]
      end
    end

    wire_pts
  end

  def build_wires(wire_pts)
    [].tap { |wires| wire_pts.each_cons(2) { |a, b| wires << LineSegment.new(a, b) } }
  end

  def find_intersections(wire1, wire2)
    wire1.map do |segment1|
      wire2.select { |segment2| segment1.intersects?(segment2) }
           .map { |segment2| segment1.intersection(segment2) }
    end.flatten
  end

  class Part1
    include Day03

    def solve(input)
      wires = input.map { |path| build_wires(map_wire_points(path)) }

      intersections = find_intersections(*wires)
      intersections.map { |p| [p, p.manhattan_distance(Point[0, 0])] }
                   .min_by(&:last).last
    end
  end

  class Part2
    include Day03

    def solve(input)
      wires = input.map { |path| build_wires(map_wire_points(path)) }

      intersections = find_intersections(*wires)
      intersections.map { |p| [p, wires.map { |wire| steps_to_point(wire, p) }.sum] }
                   .min_by(&:last).last
    end

    def steps_to_point(wire, point)
      path_segments = wire.take_while { |seg| !seg.includes?(point) }
      steps = path_segments.map(&:length).sum
      steps + path_segments.last.b.manhattan_distance(point)
    end
  end
end
