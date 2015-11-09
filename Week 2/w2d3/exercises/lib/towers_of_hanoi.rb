class TowersOfHanoi
  attr_accessor :board

  def initialize(n=3)
    stack = []
    n.downto(1) {|x| stack << x}
    @board = [[3, 2, 1],[],[]]
  end

  def play
    until end_game?
      display
      move = get_input
      move_piece(move.first, move.last)
    end
    puts "suck it, towers!"
  end

  def get_input
    puts "From which would you like to grab the top disk? 0, 1 or 2?"
    start = gets.chomp.to_i
    puts "Onto which would you like to place that disk? 0, 1 or 2?"
    finish = gets.chomp.to_i
    [start, finish]
  end

  def move_piece(start_pos, end_pos)
    self.board[end_pos].push(self.board[start_pos].pop) if valid_move?(start_pos, end_pos)
  end

  def valid_move?(start_pos, end_pos)
    return false if board[start_pos].empty?
    return true if board[end_pos].empty?
    return false if board[start_pos].last > board[end_pos].last
    true
  end

  def end_game?
    has_pieces = []
    board.each { |stack| has_pieces << (stack.length > 0) }
    return false if has_pieces[0]
    return false if has_pieces[1] && has_pieces[2]
    true
  end

  def display
    puts self
  end

  def to_s
    "[#{board[0].to_s},#{board[1].to_s},#{board[2].to_s}]"
  end
end

if __FILE__ == $PROGRAM_NAME
  g = TowersOfHanoi.new
  g.play
end
