require_relative 'tile'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(9) { Array.new(9) }
    populate_grid
  end

  def place_bombs
    bomb_array = Array.new(10) {:bomb}
    until bomb_array.empty?
      x, y = random_pos, random_pos
      grid[x][y].value = bomb_array.shift unless grid[x][y].value == :bomb
    end
  end

  def populate_grid
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        grid[row_idx][col_idx] = Tile.new(self, [row_idx, col_idx])
      end
    end
    place_bombs
  end

  def render
    grid.each do |row|
      row.each do |tile|
        if tile.revealed
          print "#{tile.value},"
        else          
          print "*,"
        end
      end
      puts ""
    end
  end

  def random_pos
    rand(9)
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    grid[x][y] = value
  end

end
