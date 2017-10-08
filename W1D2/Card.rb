class Card
  attr_accessor :face_value, :visible

  def initialize(face_value, visible = false)
    @face_value = face_value
    @visible = visible
  end

  def display_information
    if @visible
      puts "this card is face down"
    else
      @face_value
    end
  end

  def hide
    @visible = false
  end

  def reveal_card
    @visible = true
    @face_value
  end

  def ==(card)
    self.face_value == card.face_value
  end

  def to_s
    @face_value.to_s
  end

end
