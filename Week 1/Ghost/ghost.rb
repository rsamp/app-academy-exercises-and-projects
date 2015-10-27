require_relative 'player'

class GhostGame
  attr_reader :players, :dictionary
  attr_accessor :fragment

  def initialize(*players)
    @players = players
    @current_player = players.first
    @dictionary = File.readlines('ghost-dictionary.txt')
    current_player = players.first
  end

  def play_round
    current_player.guess(@fragment)
  end

  def current_player
    current_player = players.first
  end

  def previous_player
    if current_player == players.first
      return players.first
    else
      idx = players.index(current_player)
      return players[idx - 1]
    end
  end

  def next_player!
    if current_player == players.last
      current_player = players.first
    else
      idx = players.index(current_player)
      current_player = players[idx + 1]
    end
  end

  def take_turn(player)

  end

  def valid_play?(str)
    return true if ("a".."z").include?(str)
    false
  end
end

if __FILE__ == $PROGRAM_NAME
  g = GhostGame.new(Player.new("Ryan"), Player.new("Samp"))
  g.play_round
end
