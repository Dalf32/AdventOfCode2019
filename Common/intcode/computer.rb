# frozen_string_literal: true

# IntcodeComputer
#
# AUTHOR::  Kyle Mullins

require_relative 'program'
require_relative 'instruction'

module Intcode
  class Computer
    def self.program(memory, noun = nil, verb = nil)
      Intcode::Program.new(memory).tap do |program|
        program.noun = noun unless noun.nil?
        program.verb = verb unless verb.nil?
      end
    end

    def self.run_intcode(memory, input = [])
      done = false
      ptr = 0
      output = []

      until done
        instruction = Intcode::Instruction.create(memory[ptr], input, output)
        instruction.run(memory, *memory[ptr..(ptr + instruction.num_params)])
        done = instruction.terminate?
        ptr = instruction.move_pointer(ptr)
      end

      output
    end
  end
end
