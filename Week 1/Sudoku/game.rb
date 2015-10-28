require_relative 'board'
require_relative 'tile'

class SudokuGame
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def play
    until @board.solved?
      @board.render
      @board.update_tile(prompt)
    end
    @board.render
    puts "Congrats!"
  end

  def prompt
    puts "Where would you like to guess?"
    arr = gets.chomp.scan(/\d/)
    arr.map!(&:to_i)
    puts "What number?"
    value = gets.chomp
    arr << value
  end
end

if __FILE__ == $PROGRAM_NAME
  g = SudokuGame.new
  g.play
end
