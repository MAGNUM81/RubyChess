# frozen_string_literal: true

require './OODRubyChess/src/piece'
require './OODRubyChess/src/position'
# this shiny device handles generic displacements on a 8x8 chess board
class Board
  BASIC_BOUNDS = { lower_x: 0, lower_y: 0, upper_x: 7, upper_y: 7 }.freeze

  attr_accessor :upper_bound_x
  attr_accessor :upper_bound_y
  attr_accessor :lower_bound_x
  attr_accessor :lower_bound_y

  # describes a board error
  class BoardError < StandardError; end

  # describes an OutOfBounds Error
  class OutOfBoundsError < BoardError
    def message
      'The requested position is out of bounds.'
    end
  end

  # describes a piece placing error
  class OccupiedError < BoardError
    def message
      'There is already a piece there.'
    end
  end

  # describes a piece removing error
  class EmptyError < BoardError
    def message
      'There is no piece here.'
    end
  end

  # creates an empty board
  def initialize(bounds)
    self.lower_bound_x = bounds[:lower_x]
    self.lower_bound_y = bounds[:lower_y]
    self.upper_bound_x = bounds[:upper_x]
    self.upper_bound_y = bounds[:upper_y]
    @occupied_space = Array.new(upper_bound_x + 1) { Array.new(upper_bound_y + 1, piece: nil) }
  end

  def validate_positions(*positions)
    ret = true
    positions.each do |pos|
      unless validate_position_in_bounds(pos)
        ret = false
        break
      end
    end
    ret
  end

  def validate_position_in_bounds(position)
    (position.x >= lower_bound_x && position.x <= upper_bound_x) && (position.y >= lower_bound_y && position.y <= upper_bound_y)
  end

  def position_occupied(position)
    !@occupied_space[position.x][position.y][:piece].nil?
  end

  def get_piece_from_position(position)
    @occupied_space[position.x][position.y][:piece]
  end

  def place(piece, position)
    raise OutOfBoundsError unless validate_position_in_bounds(position)
    raise OccupiedError if position_occupied(position)

    @occupied_space[position.x][position.y][:piece] = piece
  end

  def remove(position)
    raise OutOfBoundsError unless validate_position_in_bounds(position)
    raise EmptyError unless position_occupied(position)

    @occupied_space[position.x][position.y][:piece] = nil
  end

  def serialize
    'Not implemented'
  end
end
