require 'rspec'
require 'array_exercises.rb'

describe Array do
  let(:with_dups) {[1,3,3,5,7,8,8,8,5]}
  let(:without_dups) {[1,3,5,7,8]}
  let(:empty) {[]}

  describe '#remove_dups' do
    it "returns an array with unique elements" do
      expect(with_dups.remove_dups).to eq(without_dups)
    end

    it "returns the same array if it doesnt have any duplicates" do
      expect(without_dups.remove_dups).to eq(without_dups)
    end

    it "returns an empty array if passed an empty array" do
      expect(empty.remove_dups).to eq([])
    end

  end


  let(:with_negatives) {[1,3,8,-8,5,-1]}
  let(:with_negatives_and_dups) {[1,3,8,-8,5,-1,-8]}
  let(:doesnt_add_to_zero) {[1,-3,-5,7,-8]}


  describe '#two_sum' do
    it "returns the coordinates of elements if they add to zero" do
      arr = [-1,1]
      expect(arr.two_sum).to eq([[0,1]])
    end

    it "returns an empty array if no combinations add to zero" do
      expect(doesnt_add_to_zero.two_sum).to eq([])
    end

    it "orders pairs according to the index of its first element" do
      expect(with_negatives.two_sum).to eq([[0,5],[2,3]])
    end

    it "orders pairs with the same first element according to the second element" do
      expect(with_negatives_and_dups.two_sum).to eq([[0,5],[2,3],[2,6]])
    end

    it "returns an empty array if passed an empty array" do
      expect(empty.two_sum).to eq([])
    end

  end

  let(:single_element) {[3]}
  let(:two_dimensional) {[[0, 1],
                          [2, 3]]}
  let(:three_dimensional) {[[0, 1, 2],
                            [3, 4, 5],
                            [6, 7, 8]]}

  describe '#my_transpose' do
    it "returns a single element if passed a single element" do
      expect(single_element.my_transpose).to eq(single_element)
    end

    it "returns an empty array if passed an empty array" do
      expect(empty.my_transpose).to eq([])
    end

    it "return the same array if transposed twice" do
      expect(three_dimensional.my_transpose.my_transpose).to eq(three_dimensional)
    end

    it "works with a two dimensional array" do
      expect(two_dimensional.my_transpose).to eq([[0, 2], [1, 3]])
    end

    it "works with a three dimensional array" do
      expect(three_dimensional.my_transpose).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
    end
  end

  let(:single_day) {[143]}
  let(:two_days) {[143, 184]}
  let(:all_days_positive) {[2, 10, 25, 100, 1000]}
  let(:all_days_negative) {[1000, 100, 25, 10, 2]}
  let(:mixed_days) {[7, 2, 100, 54, 127, 96, 37]}

  describe '#stock_picker' do
    it "returns empty array if given just one day" do
      expect(single_day.stock_picker).to eq([])
    end

    it "returns an empty array if given an empty array" do
      expect(empty.stock_picker).to eq([])
    end

    it "returns indices if given a valid list of stock prices" do
      expect(two_days.stock_picker).to eq([0,1])
    end

    it "returns first and last elements if given consecutive stock price increases" do
      expect(all_days_positive.stock_picker).to eq([0, all_days_positive.length - 1])
    end

    it "returns an empty array if given all stock price decreases" do
      expect(all_days_negative.stock_picker).to eq([])
    end

    it "correctly selects proper stock days if given increases and decreases in prices" do
      expect(mixed_days.stock_picker).to eq([1, 4])
    end
  end

end
