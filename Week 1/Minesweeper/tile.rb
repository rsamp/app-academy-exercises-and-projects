require 'byebug'

require_relative 'board'

class Tile
  attr_reader :pos, :board
  attr_accessor :value, :revealed

  POTENTIAL_NEIGHBORS_DIFF = [[0,1],
                             [0,-1],
                             [-1,0],
                             [1,0],
                             [1,1],
                             [1,-1],
                             [-1,1],
                             [-1,-1]]

  def initialize(board, pos)
    @value = nil
    @revealed = false
    @board = board
    @pos = pos
  end

  def reveal
    # debugger
    raise "You blew up" if value == :bomb
    # puts "Already revealed" if revealed
    self.revealed = true
    if neighbor_bomb_count > 0
      @value = neighbor_bomb_count
    else
      @value = "_"
      neighbors.each { |neighbor| neighbor.reveal unless neighbor.revealed}
    end

  end

  def within_bounds?(pos)
    (0..8).include?(pos[0]) && (0..8).include?(pos[1])
  end

  def neighbor_bomb_count
    bomb_count = 0
    neighbors.each { |neighbor| bomb_count += 1 if neighbor.value == :bomb }
    bomb_count
  end

  def check_neighbors
    potential_neighbors.select { |neighbor| within_bounds?(neighbor) }
  end

  def neighbors
    neighbors = []
    check_neighbors.each do |neighbor|
      neighbors << board[neighbor]
    end
    neighbors
  end

  def potential_neighbors
    POTENTIAL_NEIGHBORS_DIFF.map { |diff| [self.pos[0] + diff[0], self.pos[1] + diff[1]]}
  end

  def inspect

  end

end
