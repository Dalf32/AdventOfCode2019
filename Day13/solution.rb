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

    class ArcadeGame
      attr_reader :score

      def initialize(memory)
        @memory = memory
        @program = Intcode::Computer.program(memory)

        update_locations(run_frame)
      end

      def play
        joystick_moves = Enumerator.new { |y| loop { y << determine_move } }
        @memory[0] = 2

        loop do
          output_chunks = run_frame(joystick_moves)
          update_score(output_chunks)
          update_locations(output_chunks)
          break if blocks_left(output_chunks).zero?
        end

        self
      end

      private

      def determine_move
        return -1 if @ball_x < @paddle_x

        @ball_x == @paddle_x ? 0 : 1
      end

      def run_frame(moves = [])
        @program.run(moves).each_slice(3)
      end

      def update_locations(output_chunks)
        @ball_x = output_chunks.find { |_, _, tile| tile == 4 }.first
        @paddle_x = output_chunks.find { |_, _, tile| tile == 3 }.first
      end

      def update_score(output_chunks)
        @score = output_chunks.select { |x, y, _| x == -1 && y.zero? }
                              .map(&:last).max
      end

      def blocks_left(output_chunks)
        output_chunks.map(&:last).count(2)
      end
    end

    def solve(input)
      ArcadeGame.new(input).play.score
    end
  end
end

class Enumerator
  def take(n = 1)
    return super.first if n == 1

    super
  end
end
