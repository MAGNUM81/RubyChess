# frozen_string_literal: true

require './helpers/test_helper'
require './OODRubyChess/src/board'

# this shiny device will run unit tests against our chess constraints system
class BoardUnitTests < MiniTest::Test
  def setup
    @board = Board.new(Board::BASIC_BOUNDS)
    @random_valid_position = Position.new(rand(0..7), rand(0..7))
    @other_random_valid_position = Position.new(rand(0..7), rand(0..7))
    @random_invalid_x_position = Position.new(rand(8..16), rand(7))
    @random_invalid_y_position = Position.new(rand(7), rand(8..16))
    @some_piece = Piece.new(Piece::Type::KING, Piece::Color::WHITE)
  end

  def test_validate_position
    assert_equal(true, @board.validate_position_in_bounds(@random_valid_position))
    assert_equal(true, @board.validate_position_in_bounds(@other_random_valid_position))
    assert_equal(false, @board.validate_position_in_bounds(@random_invalid_x_position))
    assert_equal(false, @board.validate_position_in_bounds(@random_invalid_y_position))
  end

  def test_validate_many_positions
    assert_equal(true, @board.validate_positions(@random_valid_position, @other_random_valid_position))
    assert_equal(false, @board.validate_positions(@random_valid_position, @random_invalid_x_position))
    assert_equal(false, @board.validate_positions(@random_invalid_x_position, @random_invalid_y_position))
  end

  def test_position_occupied
    assert_equal(false, @board.position_occupied(@random_valid_position))
    @board.place(@some_piece, @random_valid_position)
    assert_equal(true, @board.position_occupied(@random_valid_position))
  end

  def test_piece_from_position
    assert_nil(@board.get_piece_from_position(@random_valid_position))
    @board.place(@some_piece, @random_valid_position)
    assert_equal(@some_piece, @board.get_piece_from_position(@random_valid_position))
  end

  def test_place_piece
    assert_raises Board::OutOfBoundsError do
      @board.place(@some_piece, @random_invalid_y_position)
    end
    @board.place(@some_piece, @random_valid_position)
    assert_equal(@some_piece, @board.get_piece_from_position(@random_valid_position))
    assert_raises Board::OccupiedError do
      @board.place(@some_piece, @random_valid_position)
    end
  end

  def test_remove_piece
    assert_raises Board::OutOfBoundsError do
      @board.remove(@random_invalid_x_position)
    end
    assert_raises Board::EmptyError do
      @board.remove(@random_valid_position)
    end
    @board.place(@some_piece, @random_valid_position)
    @board.remove(@random_valid_position)
    assert_nil(@board.get_piece_from_position(@random_valid_position))
  end

  def test_messages_board_errors
    ex = Board::OutOfBoundsError.new
    assert_equal('The requested position is out of bounds.', ex.message)
    ex = Board::OccupiedError.new
    assert_equal('There is already a piece there.', ex.message)
    ex = Board::EmptyError.new
    assert_equal('There is no piece here.', ex.message)
  end

  def test_serialize
    'not implemented'
  end
end
