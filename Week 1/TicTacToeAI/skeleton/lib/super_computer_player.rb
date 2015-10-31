require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    root_board = TicTacToeNode.new(game.board, mark)
    # desired_move = root_board.children.find {|child| child.winning_node?(mark)}
    # return desired_move.prev_move_pos if desired_move
    # desired_move = root_board.children.find {|child| !child.losing_node?(mark)}
    # return desired_move.prev_move_pos if desired_move
    # raise "error"
    desired_move = nil
    root_board.children.each do |child|
      if child.winning_node?(mark)
        desired_move = child.prev_move_pos
      elsif !child.losing_node?(mark) && desired_move.nil?
        desired_move = child.prev_move_pos
      else
        raise "Error"
      end
    end
    desired_move
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
