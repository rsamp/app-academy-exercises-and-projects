class Board

  def initialize
    @grid = Array.new(9) { Array.new(9) }
    place_bombs
  end

  def place_bombs
    bomb_array = Array.new(10) {:bomb}
    until bomb_array.empty?
      bomb_spot = @grid.sample.sample
      bomb_spot = bomb_array.shift unless bomb_spot == :bomb
    end
  end

end
