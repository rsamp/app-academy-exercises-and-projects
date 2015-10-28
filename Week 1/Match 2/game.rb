require_relative 'card'
require_relative 'board'

class MemoryGame
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def play
    @board.populate
    until @board.won?
      card1 = prompt
      card2 = prompt
      check_match(card1, card2)
      sleep(2)
      system("clear")
    end
  end

  private

  def prompt
    @board.render
    puts "Please enter a position: "
    @board.reveal(make_guess(gets.chomp))
  end

  def check_match(card1, card2)
    @board.render
    if card1.face_value != card2.face_value
      card1.face_up = false
      card2.face_up = false
      puts "not a match!"
    else
      puts "good job!"
    end
  end

  def make_guess(pos)
    arr = pos.scan(/\d/)
    arr.map!(&:to_i)
  end
end

if __FILE__ == $PROGRAM_NAME
  g = MemoryGame.new
  g.play
end
