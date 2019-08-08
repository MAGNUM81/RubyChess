# frozen_string_literal: true

require './helpers/test_helper'
require './OODRubyChess/src/position'

# this shiny device unit tests the Position class
class PositionUnitTests < Minitest::Test
  def setup
    @some_random_position = Position.new(rand(-10..10), rand(-10..10))
    @some_pp_position = Position.new(58, 30)
    @some_pm_position = Position.new(10, -10)
    @some_mp_position = Position.new(-42, 69)
    @some_mm_position = Position.new(-20, -18)
  end

  def test_equals
    assert_equal(true,  Position.new(58, 30) == @some_pp_position)
  end

  def test_unequals
    assert_equal(true,  @some_pp_position != @some_mm_position)
  end

  def test_plus
    exp_x = 68
    exp_y = 20
    assert_equal(exp_x, (@some_pp_position + @some_pm_position).x)
    assert_equal(exp_y, (@some_pp_position + @some_pm_position).y)
  end

  def test_minus
    exp_x = 48
    exp_y = 40
    assert_equal(exp_x, (@some_pp_position - @some_pm_position).x)
    assert_equal(exp_y, (@some_pp_position - @some_pm_position).y)
  end

  def test_aligned_and_superposed
    pos1 = Position.new(0, 24)
    pos2 = Position.new(0, 45)
    assert_equal(true, pos1.aligned_x(pos2))
    assert_equal(false, pos1.aligned_y(pos2))
    assert_equal(false, pos1.superposed(pos2))
    pos2.x = 10
    pos2.y = 24
    assert_equal(true, pos1.aligned_y(pos2))
    pos2.x = 0
    assert_equal(true, pos1.superposed(pos2))
  end

  def test_relative_vector
    exp = @some_pm_position - @some_pp_position
    assert_equal(exp.x, @some_pm_position.relative_vector(@some_pp_position).x)
    assert_equal(exp.y, @some_pm_position.relative_vector(@some_pp_position).y)
  end
end
