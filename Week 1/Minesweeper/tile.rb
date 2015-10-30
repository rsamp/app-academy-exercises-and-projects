require_relative 'board'

class Tile
  attr_reader :pos, :board, :revealed
  attr_accessor :value
  def initialize(board, pos)
    @value = nil
    @revealed = false
    @board = board
    @pos = pos
  end

  def reveal
    puts "You blew up" if value == :bomb
  end

  def neighbor_bomb_count

  end

  def neighbors

  end

  def inspect

  end

end
