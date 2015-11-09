require 'rspec'
require 'card.rb'

describe Card do

  let(:card){Card.new("Two", :hearts, 2)}
  describe '#to_s' do
    it 'prints out a visual representation of a card' do
      expect(card.to_s).to eq("Two of Hearts")
    end
  end

end
