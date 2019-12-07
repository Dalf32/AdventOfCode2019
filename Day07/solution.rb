# frozen_string_literal: true

# solution.rb
#
# AUTHOR::  Kyle Mullins

require_relative '../Common/intcode/computer'

module Day07
  def process_input(input_lines)
    input_lines.first.split(',').map(&:to_i)
  end

  def run_amp_circuit(memory, phases)
    output = [0]

    phases.each do |phase|
      output = Intcode::Computer.program(memory.dup).run([phase] + output)
    end

    output.first
  end

  class Part1
    include Day07

    def solve(input)
      max_signal = 0

      (0..4).to_a.permutation.each do |phases|
        signal = run_amp_circuit(input, phases)

        max_signal = signal if signal > max_signal
      end

      max_signal
    end
  end
end
