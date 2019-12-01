# frozen_string_literal: true

##
# advent.rb
#
# AUTHOR::  Kyle Mullins
##

require 'benchmark'

def format_day_num(day_num)
  format('%02i', day_num)
end

def include_solutions
  # noinspection RubyResolve
  (1..25).each do |day_num|
    file = "Day#{format_day_num(day_num)}/solution.rb"
    next unless File.exist?(file)

    load file
  end
rescue LoadError => e
  $stderr.puts "Failed to load #{file}: #{e.full_message}"
end

def day_exists?(day_num)
  Module.const_defined?("Day#{format_day_num(day_num)}")
end

def part_exists?(day_num, part_num)
  Class.const_defined?("Day#{format_day_num(day_num)}::Part#{part_num}")
end

def run_day(day_num)
  day_str = format_day_num(day_num)
  input_file = "Day#{day_str}/puzzle.input"
  input_lines = open(input_file).readlines.map(&:chomp)

  puts "Day #{day_num}\n------"

  (1..2).each do |part|
    run_day_part(day_num, part, input_lines) if part_exists?(day_num, part)
  end
end

def run_day_part(day_num, part_num, input_lines)
  day_str = format_day_num(day_num)
  part_class = Class.const_get("Day#{day_str}::Part#{part_num}").new

  puts "  Part #{part_num}"

  time = Benchmark.realtime do
    puts "  -> #{part_class.solve(part_class.process_input(input_lines))}\n"
  end

  time_str = time < 1 ? "#{time * 1000}ms" : "#{time}s"
  puts "    (#{time_str} elapsed)\n\n"
end

def run_single_day(day_num)
  unless day_num.between?(1, 25)
    puts 'Day # must be a number between 1 and 25'
    exit(1)
  end

  unless day_exists?(day_num)
    puts "Day #{day_num} doesn't exist yet"
    exit(2)
  end

  run_day(day_num)
end

def run_latest_day
  latest_day = (1..25).to_a.reverse.find(&method(:day_exists?))

  if latest_day.nil?
    puts 'There are no Days yet'
    exit(3)
  end

  run_day(latest_day)
end

# MAIN
unless ARGV.empty? || ARGV.length == 1
  puts 'Usage: ruby advent.rb [Day #|latest]'
  exit(1)
end

include_solutions

if ARGV.length == 1
  if ARGV.first.casecmp('latest').zero?
    run_latest_day
  else
    day_num = ARGV.first.to_i
    run_single_day(day_num)
  end
else
  (1..25).each do |day|
    break unless day_exists?(day)

    run_day(day)
  end
end
