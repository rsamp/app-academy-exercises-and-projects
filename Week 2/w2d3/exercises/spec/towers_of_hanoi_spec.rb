require 'rspec'
require 'towers_of_hanoi.rb'

describe TowersOfHanoi do

  let(:towers) {TowersOfHanoi.new(3)}
  let(:spread_towers) do
    new_towers = TowersOfHanoi.new(3)
    new_towers.board = [[3,2], [], [1]]
    new_towers
  end

  describe '#initialize' do
    it 'creates 3 arrays and populate the first with three discs' do
      expect(towers.board).to match_array([[3, 2, 1], [], []])
    end
  end

  describe '#valid_move?' do
    it "doesn't allow player to pick up nothing" do
      expect(towers.valid_move?(2, 0)).to be false
    end

    it "doesn't allow player to put larger piece on smaller piece" do
      expect(spread_towers.valid_move?(0, 2)).to be false
    end

    it "allows player to play a valid move" do
      expect(towers.valid_move?(0, 2)).to be true
    end
  end

  describe '#move_piece' do
    it 'changes the location of a piece if it\'s a valid move' do
      towers.move_piece(0,2)
      expect(towers.board).to eq(spread_towers.board)
    end

    it 'will not change the location of a piece if it is not a valid move' do
      spread_towers.move_piece(0,2)
      expect(spread_towers.board).to eq([[3,2],[],[1]])
    end

  end

  describe '#end_game?' do

    it "returns false if the game is not over" do
      expect(spread_towers.end_game?).to be false
    end

    it "returns true if all of the pieces are in column 2 (actually 1)" do
      towers.board = [[],[3,2,1],[]]
      expect(towers.end_game?).to be true
    end

    it "returns true if all of the pieces are in column 3 (actually 2)" do
      towers.board = [[],[],[3,2,1]]
      expect(towers.end_game?).to be true
    end

  end

  describe '#to_s' do
    it "turns a new board into a string!" do
      expect(towers.to_s).to eq("[[3, 2, 1],[],[]]")
    end

    it "turns a played board into a string!" do
      expect(spread_towers.to_s).to eq("[[3, 2],[],[1]]")
    end

  end


end
