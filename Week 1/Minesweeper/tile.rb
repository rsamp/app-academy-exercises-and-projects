require_relative 'board'

class Tile
  attr_reader :pos, :board
  def initialize(board, pos)
    @value = nil
    @revealed = false
    @board = board
    @pos = pos
  end

  def reveal

  end

  def neighbor_bomb_count

  end

  def neighbors

  end

  def inspect

  end

end
