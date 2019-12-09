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

    def self.run_intcode(memory, input = [], output = [])
      done = false
      ptr = 0
      relative_ptr = 0

      until done
        instruction = Intcode::Instruction.create(memory[ptr], relative_ptr,
                                                  input, output)
        instruction.run(memory, *memory[ptr..(ptr + instruction.num_params)])
        done = instruction.terminate?
        ptr = instruction.move_pointer(ptr)
        relative_ptr = instruction.new_relative_ptr
      end

      output
    end
  end
end
