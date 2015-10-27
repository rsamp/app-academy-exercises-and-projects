class Game

  attr_reader :players, :dictionary
  attr_accessor :fragment

  $current_player

  def initialize(players, fragment, dictionary='ghost-dictionary.txt')
    @players = players
    @fragment = fragment
    @dictionary = dictionary
    $current_player = players.first
  end

  def play_round

  end

  def current_player
    $current_player
  end

  def previous_player
    if $current_player == players.first
      return players.first
    else
      idx = players.index($current_player)
      return players[idx - 1]
    end
  end

  def next_player!
    if $current_player == players.last
      $current_player = players.first
    else
      idx = players.index($current_player)
      $current_player = players[idx + 1]
    end
  end

  def take_turn(player)

  end

  def valid_play?(str)
    if ("a".."z").include?(str)
  end

end

class Player

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def guess

  end

  def alert_invalid_guess

  end

end

if __FILE__ == $PROGRAM_NAME
  g = Game.new(["Ryan", "Samp"], "tes")
  g.play_round
end
