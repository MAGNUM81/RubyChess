# frozen_string_literal: true

# describes a piece of chess
class Piece
  attr_accessor :type
  attr_accessor :color

  def initialize(type, color)
    self.type = type
    self.color = color
  end

end