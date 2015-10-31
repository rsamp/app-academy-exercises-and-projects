require_relative 'board'

class Game
  attr_accessor :board

  def initialize(board=Board.new)
    @board = board
  end

  def play
    until won?
      system("clear")
      board.render
      prompt
      spot = gets.chomp.split.map(&:to_i)
      board[spot].reveal
    end
    board.render
    puts "You won!"
  end

  def prompt
    puts "Tell us the spot you'd like to reveal:"
  end

  def won?
    board.grid.each do |row|
      row.each do |tile|
      return false if tile.value == nil
      end
    end
    true
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
