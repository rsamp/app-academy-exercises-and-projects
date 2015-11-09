require_relative 'deck'

HAND_RANK = [:high_card, :pair, :two_pair,
             :three_oak, :straight, :flush,
             :full_house, :four_oak, :straight_flush]

class Hand

  attr_reader :deck
  attr_accessor :cards

  def initialize(deck)
    @deck = deck
    @cards = []

  end

  def take_card
    self.cards.push(self.deck.deal_card) unless self.cards.size >= 5
  end

  def discard(card)
    self.cards.delete(card)
  end

  def to_s
    cards.map{|card| card.to_s}.join(", ")
  end

  def beats(other)
    my_hand = self.hand_profile
    other_hand = other.hand_profile

    my_type = my_hand[:type]
    other_type = other_hand[:type]

    comparator = HAND_RANK.index(my_type) <=> HAND_RANK.index(other_type)
    if comparator == 1
      return true
    elsif comparator == -1
      return false
    else
      my_rankings = my_hand[:priority]
      other_rankings = other_hand[:priority]

      until my_rankings.empty?
        me = my_rankings.shift
        other = other_rankings.shift
        if me > other
          return true
        elsif me < other
          return false
        end
      end

      nil
    end
  end

  def hand_profile
    suits = []
    ranks = Hash.new {|h,k| h[k] = 0 }

    cards.each do |card|
      suits << card.suit
      ranks[card.rank] += 1
    end

    type = combo_type(ranks)

    unless type
      straight = check_straight(ranks)
      flush = check_flush(suits)
      type = non_combo_type(straight, flush)
    end


    value_queue = generate_rank_ordering(ranks)

    {type: type, priority: value_queue}
  end

  def generate_rank_ordering(ranks)
    ranks.keys.sort do |rank_1, rank_2|
      if ranks[rank_1] < ranks[rank_2]
        1
      elsif ranks[rank_1] > ranks[rank_2]
        -1
      else
        rank_2 <=> rank_1
      end
    end
  end

  def check_straight(ranks)
    sorted_ranks = ranks.keys.sort

    return true if sorted_ranks == [2,3,4,5,14]

    straight = true

    sorted_ranks.each_with_index do |rank, idx|
      next if idx == 0
      unless rank - 1 == sorted_ranks[idx - 1]
        straight = false
      end
    end

    straight
  end

  def check_flush(suits) #suits array
    suits.uniq.size == 1
  end

  def combo_type(ranks) #ranks hash
    type = nil
    distinct_cards = ranks.count

    case distinct_cards
    when 2
      if ranks.has_value? (3)
        type = :full_house
      else
        type = :four_oak
      end
    when 3
      if ranks.has_value?(3)
        type = :three_oak
      else
        type = :two_pair
      end
    when 4
      type = :pair
    end

    type
  end

  def non_combo_type(straight, flush)
    return :straight_flush if straight && flush
    return :flush if flush
    return :straight if straight
    :high_card
  end
end
