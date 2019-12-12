# frozen_string_literal: true

# Moon
#
# AUTHOR::  Kyle Mullins

require_relative '../Common/triple'

class Moon
  attr_reader :position, :velocity

  def initialize(position, velocity = Triple[0, 0, 0])
    @position = position
    @velocity = velocity
  end

  def gravitate_to(other_moon)
    @velocity += gravity(other_moon.position)
  end

  def move
    @position += @velocity
  end

  def energy
    potential_energy * kinetic_energy
  end

  def potential_energy
    @position.distance
  end

  def kinetic_energy
    @velocity.distance
  end

  def to_s
    "pos=#{@position}, vel=#{@velocity}"
  end

  private

  def gravity(other_pos)
    Triple[axis_gravity(@position.x, other_pos.x),
           axis_gravity(@position.y, other_pos.y),
           axis_gravity(@position.z, other_pos.z)]
  end

  def axis_gravity(axis_val, axis_other_val)
    axis_val > axis_other_val ? -1 : (axis_val == axis_other_val ? 0 : 1)
  end
end
