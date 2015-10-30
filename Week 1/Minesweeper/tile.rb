require_relative 'board'

class Tile
  attr_reader :pos, :board, :revealed
  attr_accessor :value

  POTENTIAL_NEIGHBORS = [[0,1],
                         [0,-1],
                         [-1,0],
                         [1,0],
                         [1,1],
                         [1,-1],
                         [-1,1],
                         [-1,-1]]

  def initialize(board, pos)
    @value = nil
    @revealed = true
    @board = board
    @pos = pos
  end

  def reveal
    raise "You blew up" if value == :bomb
    raise "Already revealed" if revealed
    revealed = true
    if neighbor_bomb_count > 0
      @value = neighbor_bomb_count
    end

  end

  def within_bounds?(pos)
    (0..8).include?(pos[0]) && (0..8).include?(pos[1])
  end

  def neighbor_bomb_count
    bomb_count = 0
    neighbors.each { |neighbor| bomb_count += 1 if neighbor.value == :bomb }
  end

  def neighbors
    POTENTIAL_NEIGHBORS.select { |neighbor| within_bounds?(neighbor) }
  end

  def inspect

  end

end
