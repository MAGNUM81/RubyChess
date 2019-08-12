# frozen_string_literal: true

# this shiny device will validate chess patterns, not moves
class PatternValidator
  @constraints = Piece::Type::Constraints::MAP

  def self.validate_type_pattern(piece_type, from_pos, to_pos)
    false if from_pos == to_pos
    piece_constraint = @constraints[piece_type]
    pattern = piece_constraint[:pattern]
    max_x = piece_constraint[:max_x]
    max_y = piece_constraint[:max_y]

    abs_relative_vector = from_pos.relative_vector(to_pos).abs

    return false if abs_relative_vector.x > max_x || abs_relative_vector.y > max_y

    validate_pattern(pattern, from_pos, to_pos, max_x, max_y)
  end

  def self.validate_pattern(pattern, from_pos, to_pos, max_x, max_y)
    valid = false
    pattern.each_char do |c|
      case c
      when '+' then valid = validate_vertical_cross(from_pos, to_pos)
      when 'x' then valid = validate_diagonal_cross(from_pos, to_pos)
      when 'l' then valid = validate_knight_pattern(from_pos, to_pos, max_x, max_y)
      when 'i' then valid = validate_pawn_pattern(from_pos, to_pos)
      else raise Piece::Constraints::BadPatternError
      end
      break if valid
    end
    valid
  end

  def self.validate_vertical_cross(from_pos, to_pos)
    # positions have to be aligned
    from_pos.aligned_x(to_pos) | from_pos.aligned_y(to_pos)
  end

  def self.validate_diagonal_cross(from_pos, to_pos)
    abs_relative_vector = from_pos.relative_vector(to_pos).abs
    # relative vector must be square (x == y)
    abs_relative_vector.x == abs_relative_vector.y
  end

  def self.validate_knight_pattern(from_pos, to_pos, max_x, max_y)
    abs_relative_vector = from_pos.relative_vector(to_pos).abs
    (abs_relative_vector.x == max_x && abs_relative_vector.y == max_x - 1) \
        || (abs_relative_vector.y == max_y && abs_relative_vector.x == max_y - 1)
  end

  def self.validate_pawn_pattern(from_pos, to_pos)
    abs_relative_vector = from_pos.relative_vector(to_pos).abs
    # a bit mysterious, but it should be able to validate the pattern along the Y axis
    (abs_relative_vector.aligned_y(Position.zero) | (abs_relative_vector.x == 1 && abs_relative_vector.y == 1))
  end
end
