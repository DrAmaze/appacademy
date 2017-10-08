require_relative "Card.rb"

class Board

  CARDS = [1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8]

  def self.default_grid # [ [],[],[],[] x 4]
    Array.new(4) { Array.new(4) }
  end

  def self.random
    self.new(self.default_grid, true)
  end

  attr_accessor :grid

  def initialize(grid = Board.default_grid, random = false)
    @grid = grid
    randomize if random
  end

  def randomize(count = @grid.flatten.length)
    count.times do
      populate
    end
  end

  def populate
    pos = random_pos

    until empty?(pos)
      pos = random_pos
      card = CARDS.sample
      self[pos] = card
      CARDS.delete!(card)
    end
  end

  def random_pos
    [rand(size), rand(size)]
  end

  def size
    @grid.length
  end

  def won?
    @grid.flatten.none? { |card| card.visible == false } #hmmm
  end

  def render
    @grid.each do |row|
      row.each { |col| puts col }
    end
  end


  def reveal(guessed_pos)
    # if self[guessed_pos].value == true
    #   "this card is face up, silly!"
    # else
      self[guessed_pos[0]][guessed_pos[1]].reveal_card
    # end
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    grid[row][col] = value
  end

end
