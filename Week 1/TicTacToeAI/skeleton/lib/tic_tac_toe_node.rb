require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return false if @board.tied? || @board.winner == evaluator
    return true if @board.over? #&& evaluator != @board.winner
    loser_our_turn = children.all? do |child|
      child.losing_node?(evaluator)
    end
    loser_opp_turn = children.any? do |child|
      child.losing_node?(evaluator)
    end
    if evaluator == @next_mover_mark
      loser_our_turn
    else
      loser_opp_turn
    end
  end

  def winning_node?(evaluator)
    return true if @board.winner == evaluator
    children.each do |child|
      return true if child.winning_node?(evaluator)
    end
    false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    next_mark = @next_mover_mark
    next_mark == :x ? next_mark = :o : next_mark = :x
    @board.rows.each_with_index do |row, x|
      row.each_with_index do |_, y|
        pos = [x, y]
        if @board.empty?(pos)
          new_board_node = TicTacToeNode.new(@board.dup, next_mark, pos)
          new_board_node.board[pos] = @next_mover_mark
          children << new_board_node
        end
      end
    end
    children
  end
end
