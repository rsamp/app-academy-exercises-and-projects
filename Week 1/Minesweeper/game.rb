require_relative 'board'

class Game
  attr_accessor :board

  def initialize(board=Board.new)
    @board = board
  end

  def play
    # until
      board.render
    # end
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
