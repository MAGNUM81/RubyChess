# frozen_string_literal: true

require './helpers/test_helper'

# this shiny device executes unit tests on the Piece class
class PieceUnitTests < MiniTest::Test
  def setup
    @some_white_queen = Piece.new(Piece::Type::QUEEN, Piece::Color::WHITE)
    @some_black_knight = Piece.new(Piece::Type::KNIGHT, Piece::Color::BLACK)
  end

  def test_raise_color_or_type
    assert_raises Piece::Color::BadColorError do
      Piece.new(Piece::Type::BISHOP, 'YOLO')
    end

    assert_raises Piece::Type::BadTypeError do
      Piece.new('GRASS', Piece::Color::WHITE)
    end
  end

  def test_equals
    assert_equal(false, @some_white_queen == @some_black_knight)
  end

  def test_unequals
    assert_equal(true, @some_white_queen != @some_black_knight)
  end
end
