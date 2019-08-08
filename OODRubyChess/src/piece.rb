# frozen_string_literal: true

require 'securerandom'

# describes a piece of chess
class Piece
  # contains the constants used to tag pieces
  class Type
    class BadTypeError < StandardError; end
    KING = 'King'
    QUEEN = 'Queen'
    TOWER = 'Rook'
    BISHOP = 'Bishop'
    KNIGHT = 'Knight'
    PAWN = 'Pawn'
    TYPES = [KING, QUEEN, PAWN, TOWER, BISHOP, KNIGHT].freeze
  end
  # contains the color constants for the pieces
  class Color
    class BadColorError < StandardError; end
    WHITE = 'White'
    BLACK = 'Black'
    COLORS = [WHITE, BLACK].freeze
  end

  attr_accessor :type
  attr_accessor :color
  attr_accessor :uuid

  def initialize(type, color)
    raise Color::BadColorError unless validate_color(color)
    raise Type::BadTypeError unless validate_type(type)

    self.type = type.freeze
    self.color = color.freeze
    self.uuid = SecureRandom.uuid.freeze
  end

  def validate_color(color)
    Color::COLORS.include?(color)
  end

  def validate_type(type)
    Type::TYPES.include?(type)
  end

  def ==(other)
    (uuid == other.uuid)
  end

  def !=(other)
    uuid != other.uuid
  end
end
