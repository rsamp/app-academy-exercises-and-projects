class Tile
  attr_accessor :value, :given

  def initialize(value)
    @value = value
    @given = @value != 0
  end

  def to_s
    @value.to_s
  end
end
