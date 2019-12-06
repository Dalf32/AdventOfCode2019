# frozen_string_literal: true

# Orbit
#
# AUTHOR::  Kyle Mullins

class Orbit
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def orbits(orbits_around)
    @orbits_around = orbits_around
  end

  def orbit_count
    return 1 if @orbits_around.nil?

    @orbits_around.orbit_count + 1
  end

  def orbit_list
    return [] if @orbits_around.nil?

    @orbits_around.orbit_list + [@orbits_around]
  end

  def to_s
    "#{@orbits_around&.name || 'COM'} ) #{@name}"
  end
end
