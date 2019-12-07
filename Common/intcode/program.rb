# Program
#
# AUTHOR::  Kyle Mullins

require_relative 'computer'

module Intcode
  class Program
    def initialize(memory)
      @memory = memory
    end

    def noun=(noun)
      @memory[1] = noun
    end

    def verb=(verb)
      @memory[2] = verb
    end

    def run(input = [], output = [])
      Intcode::Computer.run_intcode(@memory, input, output)
    end
  end
end
