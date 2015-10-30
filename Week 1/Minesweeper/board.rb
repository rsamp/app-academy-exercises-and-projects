class Board

  def initialize
    @grid = Array.new(9) { Array.new(9) }
  end

  def place_bombs
    bomb_array = Array.new(10) {:bomb}
    10.times do
      @grid.sample.sample = bomb_array.shift
    end
  end

end
