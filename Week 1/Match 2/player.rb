require_relative 'board'

class Player
  attr_reader :board

  def initialize
    @board
  end

  def prompt
    @board.render
    puts "Please enter a position: "
    @board.reveal(make_guess(gets.chomp))
  end
end
