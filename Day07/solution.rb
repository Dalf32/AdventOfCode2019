# frozen_string_literal: true

# solution.rb
#
# AUTHOR::  Kyle Mullins

require 'concurrent-edge'
require_relative '../Common/intcode/computer'

module Day07
  def process_input(input_lines)
    input_lines.first.split(',').map(&:to_i)
  end

  def run_amp_circuit(memory, phases)
    channels = setup_channels(phases)
    last_thread = nil

    channels.each_cons(2) do |input, output|
      last_thread = Thread.new { Intcode::Computer.program(memory.dup).run(input, output) }
    end

    last_thread.join
    channels.last.take
  end

  def setup_channels(phases, initial_input = 0)
    channels = phases.map do |phase|
      Concurrent::Channel.new(capacity: 10).tap do |channel|
        channel << phase
      end
    end

    channels << channels[0]
    channels[0] << initial_input
    channels
  end

  def optimize_signal(input, phase_range)
    max_signal = 0

    phase_range.to_a.permutation.each do |phases|
      signal = run_amp_circuit(input, phases)

      max_signal = signal if signal > max_signal
    end

    max_signal
  end

  class Part1
    include Day07

    def solve(input)
      optimize_signal(input, (0..4))
    end
  end

  class Part2
    include Day07

    def solve(input)
      optimize_signal(input, (5..9))
    end
  end
end
