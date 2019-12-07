# frozen_string_literal: true

# Instruction
#
# AUTHOR::  Kyle Mullins

class Array
  alias take shift
end

module Intcode
  class Instruction
    def self.create(instr, input, output)
      instr = format('%05d', instr)
      opcode = instr[-2..-1].to_i
      pmodes = instr.chars[0..2].map(&:to_i).reverse

      instruction = instructions.find { |i| i.opcode == opcode } || InvalidInstruction
      instruction.new(pmodes, input, output)
    end

    def self.instructions
      @instructions ||= []
    end

    def self.inherited(subclass)
      instructions << subclass
    end

    def initialize(pmodes, input, output)
      @pmodes = pmodes
      @input = input
      @output = output
    end

    def terminate?
      false
    end

    def move_pointer(pointer)
      pointer + num_params + 1
    end

    protected

    def param(memory, value, pmode)
      pmode.zero? ? memory[value] : value
    end
  end

  class AddInstruction < Instruction
    def self.opcode
      1
    end

    def num_params
      3
    end

    def run(memory, _opcode, *params)
      memory[params[2]] = param(memory, params[0], @pmodes[0]) +
                          param(memory, params[1], @pmodes[1])
    end
  end

  class MultiplyInstruction < Instruction
    def self.opcode
      2
    end

    def num_params
      3
    end

    def run(memory, _opcode, *params)
      memory[params[2]] = param(memory, params[0], @pmodes[0]) *
                          param(memory, params[1], @pmodes[1])
    end
  end

  class InputInstruction < Instruction
    def self.opcode
      3
    end

    def num_params
      1
    end

    def run(memory, _opcode, *params)
      memory[params[0]] = @input.take
    end
  end

  class OutputInstruction < Instruction
    def self.opcode
      4
    end

    def num_params
      1
    end

    def run(memory, _opcode, *params)
      @output << param(memory, params[0], @pmodes[0])
    end
  end

  class HaltInstruction < Instruction
    def self.opcode
      99
    end

    def num_params
      0
    end

    def run(_memory, _opcode, *_params) end

    def terminate?
      true
    end
  end

  class InvalidInstruction < Instruction
    def self.opcode
      -1
    end

    def num_params
      0
    end

    def run(_memory, opcode, *_params)
      puts "Invalid instruction: #{opcode}"
    end

    def terminate?
      true
    end
  end

  class JumpTrueInstruction < Instruction
    def self.opcode
      5
    end

    def num_params
      2
    end

    def run(memory, _opcode, *params)
      test_val = param(memory, params[0], @pmodes[0])
      @new_pointer = test_val.zero? ? nil : param(memory, params[1], @pmodes[1])
    end

    def move_pointer(pointer)
      @new_pointer || super(pointer)
    end
  end

  class JumpFalseInstruction < Instruction
    def self.opcode
      6
    end

    def num_params
      2
    end

    def run(memory, _opcode, *params)
      test_val = param(memory, params[0], @pmodes[0])
      @new_pointer = test_val.zero? ? param(memory, params[1], @pmodes[1]) : nil
    end

    def move_pointer(pointer)
      @new_pointer || super(pointer)
    end
  end

  class LessThanInstruction < Instruction
    def self.opcode
      7
    end

    def num_params
      3
    end

    def run(memory, _opcode, *params)
      val1 = param(memory, params[0], @pmodes[0])
      val2 = param(memory, params[1], @pmodes[1])
      memory[params[2]] = val1 < val2 ? 1 : 0
    end
  end

  class EqualToInstruction < Instruction
    def self.opcode
      8
    end

    def num_params
      3
    end

    def run(memory, _opcode, *params)
      val1 = param(memory, params[0], @pmodes[0])
      val2 = param(memory, params[1], @pmodes[1])
      memory[params[2]] = val1 == val2 ? 1 : 0
    end
  end
end
