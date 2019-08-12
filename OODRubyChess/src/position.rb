# frozen_string_literal: true

# this shiny device contains methods to store and compare positions
class Position
  attr_accessor :x
  attr_accessor :y

  def initialize(x_axis, y_axis)
    self.x = x_axis
    self.y = y_axis
  end

  def self.zero
    new(0, 0)
  end

  def self.random
    new(rand(0..7), rand(0..7))
  end

  def relative_vector(position)
    Position.new((x - position.x), (y - position.y))
  end

  def aligned_y(position)
    x == position.x
  end

  def aligned_x(position)
    y == position.y
  end

  def superposed(position)
    aligned_x(position) && aligned_y(position)
  end

  def ==(other)
    (x == other.x && y == other.y)
  end

  def !=(other)
    (x != other.x && y != other.y)
  end

  def +(other)
    Position.new(x + other.x, y + other.y)
  end

  def -(other)
    Position.new(x - other.x, y - other.y)
  end

  def abs
    Position.new(x.abs, y.abs)
  end


end
