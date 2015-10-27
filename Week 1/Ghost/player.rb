class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def guess(fragment)
    puts "Current fragment is #{fragment}"
    prompt
    gets.chomp.downcase
  end

  def alert_invalid_move(letter)
    puts "#{letter} is not a valid move."
    prompt
  end

  def prompt
    puts "Please play a letter that could potentially make a word: "
  end
end
