require 'colorize'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(9) { Array.new(9) }
    @grid = from_file("sudoku1.txt")
  end

  def from_file(file)
    temp_grid = File.readlines(file).map(&:chomp)
    temp_grid.each_with_index do |row, x|
      row = row.split(//)
      row.each_with_index do |val, y|
        @grid[x][y] = Tile.new(val.to_i)
      end
    end
    @grid
  end

  def render
    system("clear")
    @grid.each do |row|
      row.each do |el|
        el.given ? print(el.to_s.colorize(:blue)) : print(el.to_s)
        print " "
      end
      puts "\n"
    end
  end

  def solved?
    rows = @grid.all? { |row| check_sum(row) }
    cols = @grid.transpose.all? { |col| check_sum(col) }
    true if rows && cols
  end

  def check_sum(line)
    sum = 0
    line.each do |tile|
      sum += tile.value
    end
    return false unless sum == 45
    true
  end

  def update_tile(input)
    tile = @grid[input[0]][input[1]]
    tile.value = input[2].to_i unless tile.given
  end
end
