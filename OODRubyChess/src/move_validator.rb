# frozen_string_literal: true

# this shiny device will validate chess moves
class MoveValidator
  def initialize(board)
    @board = board
    @constraints = Piece::Type::Constraints::MAP
  end

  def validate_move_in_bounds(from_pos, to_pos)
    @board.validate_positions(from_pos, to_pos)
  end

  def validate_piece_can_do(piece, from_pos, to_pos)
    # raise error if piece isn't at from_pos
    # return false if piece type cant do
    # return true if piece type can do
  end

  def validate_piece_pattern_match(piece, from_pos, to_pos)
    false if from_pos == to_pos
    piece_constraint = @constraints[piece.type]
    pattern = piece_constraint[:pattern]
    max_x = piece_constraint[:max_x]
    max_y = piece_constraint[:max_y]

    relative_vector = from_pos.relative_vector(to_pos)
    false if relative_vector.x.abs > max_x
    false if relative_vector.y.abs > max_y

    if pattern.include? '+'
      false unless from_pos.aligned_x(to_pos) | from_pos.aligned_y(to_pos)
      # validate North-South-East-West cross
    end
    if pattern.include? 'x'
      # validate diagonal cross
    end
    if pattern.include? 'i'
      # validate pawn pattern
      if relative_vector.x.abs == max_x
        false if relative_vector.y.abs == max_y
      end
    end
    if pattern.include? 'l'
      # validate knight pattern
      relative_vector = from_pos.relative_vector(to_pos)
      true if (relative_vector.x.abs > relative_vector.y.abs || relative_vector.x.abs < relative_vector.y.abs) \
        && (relative_vector.x.abs <= max_x && relative_vector.y <= max_y) \
        && (relative_vector.x.abs + relative_vector.y.abs == 3)
    end
  end
end
