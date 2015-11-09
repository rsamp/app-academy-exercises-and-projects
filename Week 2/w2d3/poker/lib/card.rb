class Card
  attr_reader :name, :suit, :rank

  def initialize(name, suit, rank)
    @name = name
    @suit = suit
    @rank = rank
  end

  def to_s
    "#{name} of #{suit.to_s.capitalize}"
  end

end
