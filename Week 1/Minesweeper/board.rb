class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(9) { Array.new(9) }
    place_bombs
  end

  def place_bombs
    bomb_array = Array.new(10) {:bomb}
    until bomb_array.empty?
      x, y = random_pos, random_pos
      grid[x][y] = bomb_array.shift unless grid[x][y] == :bomb
    end
  end

  def render
    grid.each { |row| p row }
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
