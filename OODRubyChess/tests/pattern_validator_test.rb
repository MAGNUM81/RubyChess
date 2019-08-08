# frozen_string_literal: true

require './helpers/test_helper'
require './OODRubyChess/src/pattern_validator'

# this shiny device executes unit tests on the PatternValidator class
class PatternValidatorUnitTests < Minitest::Test
  def setup
    @from_pos = Position.new(3, 3)
  end

  # tests without context or additional objects
  def test_vertical_cross
    to_aligned_y = Position.new(3, 7)
    to_aligned_x = Position.new(7, 3)

    assert_equal(true, PatternValidator.validate_vertical_cross(@from_pos, to_aligned_x))
    assert_equal(true, PatternValidator.validate_vertical_cross(@from_pos, to_aligned_y))
  end

  def test_diagonal_cross
    to_diagonale = Position.new(1, 1)
    assert_equal(true, PatternValidator.validate_diagonal_cross(@from_pos, to_diagonale))
  end

  def test_knight_pattern
    to_knight_northeast = Position.new(5, 4)
    to_knight_southwest = Position.new(5, 4)
    assert_equal(true, PatternValidator.validate_knight_pattern(@from_pos, to_knight_northeast, 2, 2))
    assert_equal(true, PatternValidator.validate_knight_pattern(@from_pos, to_knight_southwest, 2, 2))
  end

  def test_pawn_pattern
    to_pawn_northwest = Position.new(2, 4)
    to_pawn_north_north = Position.new(3, 5)
    to_pawn_southeast = Position.new(4, 2)
    to_pawn_south_south = Position.new(3, 1)
    assert_equal(true, PatternValidator.validate_pawn_pattern(@from_pos, to_pawn_northwest))
    assert_equal(true, PatternValidator.validate_pawn_pattern(@from_pos, to_pawn_north_north))
    assert_equal(true, PatternValidator.validate_pawn_pattern(@from_pos, to_pawn_southeast))
    assert_equal(true, PatternValidator.validate_pawn_pattern(@from_pos, to_pawn_south_south))
  end

  # tests using a bit more context, and the Piece subclasses

  def test_validate_king_pattern
    king_type = Piece::Type::KING
    valid_to_pos = Position.new(@from_pos.x + 1, @from_pos.y + 1)
    invalid_to_pos = Position.new(@from_pos.x + 2, @from_pos.y + 2)
    assert_equal(true, PatternValidator.validate_type_pattern(king_type, @from_pos, valid_to_pos))
    assert_equal(false, PatternValidator.validate_type_pattern(king_type, @from_pos, invalid_to_pos))
  end

  def test_validate_queen_pattern
    queen_type = Piece::Type::QUEEN
    valid_to_diago_pos = Position.new(@from_pos.x + 3, @from_pos.y + 3)
    valid_to_cross_pos = Position.new(@from_pos.x, @from_pos.y + 3)
    invalid_to_pos = Position.new(@from_pos.x + 2, @from_pos.y + 1)
    assert_equal(true, PatternValidator.validate_type_pattern(queen_type, @from_pos, valid_to_diago_pos))
    assert_equal(true, PatternValidator.validate_type_pattern(queen_type, @from_pos, valid_to_cross_pos))
    assert_equal(false, PatternValidator.validate_type_pattern(queen_type, @from_pos, invalid_to_pos))
  end

  def test_validate_bishop_pattern
    bishop_type = Piece::Type::BISHOP
    valid_to_diago_pos = Position.new(@from_pos.x + 3, @from_pos.y + 3)
    invalid_to_cross_pos = Position.new(@from_pos.x, @from_pos.y + 3)
    assert_equal(true, PatternValidator.validate_type_pattern(bishop_type, @from_pos, valid_to_diago_pos))
    assert_equal(false, PatternValidator.validate_type_pattern(bishop_type, @from_pos, invalid_to_cross_pos))
  end

  def test_validate_knight_pattern
    knight_type = Piece::Type::KNIGHT
    valid_to_pos = Position.new(@from_pos.x + 2, @from_pos.y + 1)
    invalid_to_cross_pos = Position.new(@from_pos.x, @from_pos.y + 3)
    assert_equal(true, PatternValidator.validate_type_pattern(knight_type, @from_pos, valid_to_pos))
    assert_equal(false, PatternValidator.validate_type_pattern(knight_type, @from_pos, invalid_to_cross_pos))
  end

  def test_validate_rook_pattern
    rook_type = Piece::Type::ROOK
    invalid_to_diago_pos = Position.new(@from_pos.x + 3, @from_pos.y + 3)
    valid_to_cross_pos = Position.new(@from_pos.x, @from_pos.y - 3)
    assert_equal(true, PatternValidator.validate_type_pattern(rook_type, @from_pos, valid_to_cross_pos))
    assert_equal(false, PatternValidator.validate_type_pattern(rook_type, @from_pos, invalid_to_diago_pos))
  end

  def test_validate_pawn_pattern
    pawn_type = Piece::Type::PAWN
    invalid_to_side_pos = Position.new(@from_pos.x + 1, @from_pos.y)
    valid_to_northeast = Position.new(@from_pos.x + 1, @from_pos.y + 1)
    valid_to_north = Position.new(@from_pos.x, @from_pos.y + 2)
    assert_equal(false, PatternValidator.validate_type_pattern(pawn_type, @from_pos, invalid_to_side_pos))
    assert_equal(true, PatternValidator.validate_type_pattern(pawn_type, @from_pos, valid_to_northeast))
    assert_equal(true, PatternValidator.validate_type_pattern(pawn_type, @from_pos, valid_to_north))
  end
end
