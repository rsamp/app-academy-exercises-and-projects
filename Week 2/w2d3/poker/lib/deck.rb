require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = generate_cards
  end

  def generate_cards
    cards = []
    suits = [:clubs, :diamonds, :hearts, :spades]
    values = {2 => "Two", 3 => "Three", 4 => "Four",
              5 => "Five", 6 => "Six", 7 => "Seven",
              8 => "Eight", 9 => "Nine", 10 => "Ten",
              11 => "Jack", 12 => "Queen", 13 => "King",
              14 => "Ace"}
    suits.each do |suit|
      values.each do |rank, name|
        cards << Card.new(name, suit, rank)
      end
    end
    cards
  end

  def deal_card
    self.cards.pop
  end

  def shuffle
    self.cards.shuffle!
  end
end
# 
# d = Deck.new
# d.cards.each {|card| puts card }
# d.shuffle
# puts
# d.cards.each {|card| puts card }
