require 'rspec'
require 'deck.rb'

describe Deck do

  let(:deck){Deck.new}
  let(:shuffled_deck){Deck.new.shuffle}
  describe '#initialize' do
    it 'starts with 52 cards' do
      expect(deck.cards.size).to eq(52)
    end

    it 'has no duplicate cards' do
      expect(deck.cards.uniq).to eq(deck.cards)
    end
  end

  describe '#deal_card' do
    it 'returns a card' do
      expect(deck.deal_card).to be_a(Card)
    end
  end


  describe '#shuffle' do
    it 'shuffles a deck' do
      expect(shuffled_deck).to_not eq(deck)
    end
  end

end
