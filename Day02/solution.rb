# frozen_string_literal: true

# solution.rb
#
# AUTHOR::  Kyle Mullins

module Day02
  def process_input(input_lines)
    input_lines.first.split(',').map(&:to_i)
  end

  def run_program(memory, noun, verb)
    memory[1] = noun
    memory[2] = verb

    run_intcode(memory)
  end

  def run_intcode(memory)
    done = false
    index = 0

    until done
      case memory[index]
      when 1
        add(memory, *memory[(index + 1)..(index + 3)])
      when 2
        multiply(memory, *memory[(index + 1)..(index + 3)])
      when 99
        done = true
      else
        puts 'Error!'
      end

      index += 4
    end
  end

  def add(memory, input_a, input_b, output)
    memory[output] = memory[input_a] + memory[input_b]
  end

  def multiply(memory, input_a, input_b, output)
    memory[output] = memory[input_a] * memory[input_b]
  end

  class Part1
    include Day02

    def solve(input)
      run_program(input, 12, 2)

      input[0]
    end
  end

  class Part2
    include Day02

    def solve(input)
      (0..99).each do |noun|
        (0..99).each do |verb|
          memory = input.dup
          run_program(memory, noun, verb)

          return 100 * noun + verb if memory[0] == 19_690_720
        end
      end
    end
  end
end
