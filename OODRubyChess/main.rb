#!/usr/bin/env ruby
# frozen_string_literal: true

require './OODRubyChess/src/position_parser'
require './OODRubyChess/src/board'
require './OODRubyChess/src/pattern_validator'

interactive_mode = ARGV.empty?
rules = 'First player always has white tokens'
header = 'Please enter your first move : '
usage = 'If you want to play an automatic game : ruby main.rb <filepath>'
length_game = 0
if interactive_mode
  puts 'Bonjour!'
  puts "\n\t" + usage
  puts "\n\t" + rules
  puts "\n\t" + "To quit, type 'exit'"
  puts ''
  print header
else
  length_game = (File.open ARGV[0]).readlines.length
  puts ''
end

def pretty_format(movement); end

turn = nil
next_turn = Piece::Color::WHITE
board = Board.default

ARGF.each_with_index do |line, index|
  break if line == 'exit'

  turn = next_turn
  splitted = line.split(' ')
  src = PositionParser.parse(splitted[0])
  dest = PositionParser.parse(splitted[1])
  src_piece = board.get_piece_from_position(src)
  unless src_piece.color == turn
    puts "This token isn't yours."
    next_turn = turn
    # get to the next iteration of the loop, because the turn restarts
    next
  end

  piece_type = src_piece.type

  # TODO : if current player's king is menaced, allow only the king's position to be selected as src pos

  unless PatternValidator.validate_type_pattern(piece_type, src, dest)
    puts 'Illegal move.'
    next_turn = turn
    next
  end

  # TODO : validate if move can be done in generic board context (ignoring king constraints)
  #
  # TODO : check if ally king is menaced without that token in place. If so, cancel the move

  dest_piece = board.get_piece_from_position(dest)
  if dest_piece.color == turn
    puts 'Illegal move : friendly fire'
    next_turn = turn
    next
  end
  board.remove(src)
  board.remove(dest) if board.position_occupied(dest)
  # TODO : fire kill event
  board.place(src, dest)

  next_turn = Piece::Color.next(turn)

  # TODO : check if next player's king is menaced
  # TODO : if next player's king cannot move, end the game, with current player as winner

  puts header if index == length_game
end
