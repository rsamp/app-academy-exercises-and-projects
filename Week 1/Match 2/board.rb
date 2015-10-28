class Board
  attr_reader :grid

  def initialize(grid = Array.new(4) { Array.new(4) })
    @grid = grid
  end

  def populate
    cards = generate_deck
    @grid.map! do |row|
      row.map! do |_|
        x = cards.sample
        random_card = Card.new(x)
        idx = cards.index(x)
        cards.delete_at(idx)
        random_card
      end
    end
  end

  def generate_deck
    total = @grid.length * @grid[0].length
    max = total / 2
    cards = []
    i = 1
    while i <= max
      cards << i
      cards << i
      i += 1
    end
    cards
  end

  def render
    @grid.each do |row|
      row.each do |el|
        if el.face_up
          print el.face_value
        else
          print "X"
        end
      end
      print "\n"
    end
  end

  def won?
    @grid.each do |row|
      row.each { |card| return false unless card.face_up }
    end
    true
  end

  def reveal(guessed_pos)
    self[guessed_pos].face_up = true unless self[guessed_pos].face_up
    self[guessed_pos]
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def grid_full?
    @grid.each do |row|
      return false if row.include?(nil)
    end
    true
  end
end
