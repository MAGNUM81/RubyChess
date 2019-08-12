# frozen_string_literal: true

# this shiny device will parse human chess positions to computer chess positions
class PositionParser
  def self.parse(str_position)
    pos = Position.new(-1, -1)
    str_position.each_char do |c|
      pos.x = c.ord - 65 if (65..72).include? c.ord
      pos.y = c.ord - 49 if (49..56).include? c.ord
    end
    pos
  end
end
