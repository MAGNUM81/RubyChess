# frozen_string_literal: true

require 'securerandom'

# describes a piece of chess
class Piece
  # contains the constants used to tag pieces
  class Type
    class BadTypeError < StandardError; end
    KING = 'King'
    QUEEN = 'Queen'
    ROOK = 'Rook'
    BISHOP = 'Bishop'
    KNIGHT = 'Knight'
    PAWN = 'Pawn'
    TYPES = [KING, QUEEN, PAWN, ROOK, BISHOP, KNIGHT].freeze

    class Constraints
      CKING = { pattern: '+x', max_x: 1, max_y: 1 }.freeze
      CQUEEN = { pattern: '+x', max_x: 7, max_y: 7 }.freeze
      CROOK = { pattern: '+', max_x: 7, max_y: 7 }.freeze
      CBISHOP = { pattern: 'x', max_x: 7, max_y: 7 }.freeze
      CKNIGHT = { pattern: 'l', max_x: 2, max_y: 2 }.freeze
      CPAWN = { pattern: 'i', max_x: 1, max_y: 2 }.freeze
      MAP = { King: CKING, Queen: CQUEEN, Rook: CROOK, Bishop: CBISHOP, Knight: CKNIGHT, Pawn: CPAWN }.freeze
    end
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
