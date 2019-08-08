# frozen_string_literal: true

# this shiny device contains methods to store and compare positions
class Position
  attr_accessor :x
  attr_accessor :y

  def initialize(x_axis, y_axis)
    self.x = x_axis
    self.y = y_axis
  end

  def relative_vector(position)
    Position.new((x - position.x).abs, (y - position.y).abs)
  end

  def aligned_x(position)
    x == position.x
  end

  def aligned_y(position)
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
end
