require 'rspec'
require 'hand.rb'

describe Hand do
  let(:deck){ Deck.new }
  let(:hand) { Hand.new(deck)}

  describe '#initialize' do
    it 'has an empty hand' do
      expect(hand.cards).to eq([])
    end

    it "references a full deck" do
      expect(hand.deck.cards.size).to eq(52)
    end
  end

  describe '#take_card' do
    it 'adds a card to the hand' do
      prev_hand_size = hand.cards.size
      hand.take_card
      expect(hand.cards.size).to eq(prev_hand_size + 1)
    end

    it 'takes a card from the deck' do
      prev_deck_size = hand.deck.cards.size
      hand.take_card
      expect(hand.deck.cards.size).to eq(prev_deck_size - 1)
    end

    it 'will not add a sixth card' do
      6.times{ hand.take_card}
      expect(hand.cards.size).to eq(5)
    end

  end

  describe '#discard' do
    it 'deletes the right card' do
      card_to_discard = Card.new("Six", :clubs, 6)
      hand.cards = [Card.new("Two", :clubs, 2),
                    Card.new("Two", :spades, 2),
                    Card.new("Two", :hearts, 2),
                    Card.new("Two", :diamonds, 2),
                    card_to_discard]
      hand.discard(card_to_discard)
      expect(hand.cards).not_to include(card_to_discard)
    end
  end

  let(:full_house_hash){{8 => 2, 7 => 3}}
  let(:four_oak_hash){{8 => 4, 7 => 1}}
  let(:three_oak_hash){{8 => 3, 7 => 1, 6 => 1}}
  let(:two_pair_hash){{8 => 2, 7 => 1, 6 => 2}}
  let(:pair_hash){{8 => 1, 7 => 1, 6 => 2, 11 => 1}}
  let(:straight){{8 => 1, 7 => 1, 6 => 1, 9 => 1, 10 => 1}}
  let(:high_card){{8 => 1, 7 => 1, 6 => 1, 2 => 1, 10 => 1}}
  let(:ace_low_straight){{2 => 1, 3 => 1, 5 => 1, 14 => 1, 4 => 1}}

  describe '#combo_type' do
    it 'recognizes a full house' do
      expect(hand.combo_type(full_house_hash)).to eq(:full_house)
    end

    it 'recognizes four of a kind' do
      expect(hand.combo_type(four_oak_hash)).to eq(:four_oak)
    end

    it 'recognizes three of a kind' do
      expect(hand.combo_type(three_oak_hash)).to eq(:three_oak)
    end

    it 'recognizes two pair' do
      expect(hand.combo_type(two_pair_hash)).to eq(:two_pair)
    end

    it 'recognizes a pair' do
      expect(hand.combo_type(pair_hash)).to eq(:pair)
    end

    it 'returns nil if not a combo-type hand' do
      expect(hand.combo_type(straight)).to be_nil
    end
  end

  describe '#check_straight' do
    it 'recognizes a straight' do
      expect(hand.check_straight(straight)).to be true
    end

    it 'recognizes a non straight' do
      expect(hand.check_straight(high_card)).to be false
    end

    it 'recognizes an ace-low straight' do
      expect(hand.check_straight(ace_low_straight)).to be true
    end
  end

  let(:flush_hand){[:clubs,:clubs,:clubs,:clubs,:clubs]}
  let(:non_flush_hand){[:clubs,:diamonds,:clubs,:clubs,:hearts]}

  describe '#check_flush' do
    it 'recognizes a flush' do
      expect(hand.check_flush(flush_hand)).to be true
    end

    it 'recognizes a non-flush' do
      expect(hand.check_flush(non_flush_hand)).to be false
    end
  end

  describe '#generate_rank_ordering' do

    it 'sorts a high-card' do
      expect(hand.generate_rank_ordering(high_card)).to eq([10,8,7,6,2])
    end

    it 'sorts a pair' do
      expect(hand.generate_rank_ordering(pair_hash)).to eq([6,11,8,7])
    end

    it 'sorts a two-pair' do
      expect(hand.generate_rank_ordering(two_pair_hash)).to eq([8,6,7])
    end
  end


  #no tests for
    #hand_profile
    #beats

end
