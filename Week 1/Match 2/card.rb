class Card
  attr_accessor :face_value, :face_up

  def initialize(face_value)
    @face_value = face_value
    @face_up = false
  end

  def display
    return @face_value if @face_up
    nil
  end

  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end

  def to_s
    p @face_value
  end
end
