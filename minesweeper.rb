class Board
  BOARD_SIZE = 9

  def initialize(num_bombs)
    @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
    @num_bombs = num_bombs
    populate

  end

  def render
    puts "  #{(0..8).to_a.join(" ")}"
    grid.each_with_index do |row, i|
      row.each { |tile| print "#{tile.value}" }
    end
    puts
  end

  def [](pos)
    y, x = pos
    @grid[y][x]
  end

  def []=(pos, value)
    y, x = pos
    @grid[y][x] = value
  end

  private

  def populate
    populate_bombs
    @grid.each do |row|
      row.each do |col|
        next if @grid[row][col].is_a?(Tile)
        @grid[row][col] = Tile.new(bombs_adjacent)
      end
    end
  end

  def bombs_adjacent(pos)
    count = 0
    (pos[0] - 1..pos[0] + 1).each do |row|
      (pos[1] - 1..pos[1] + 1).each do |col|
        if @grid[row][col].is_a?(Tile)
          count += 1 if @grid[row][col].value == :bomb
        end
      end
    end
    count
  end

  def populate_bombs
    bomb_positions.each do |pos|
      @grid[pos[0]][pos[1]] = Tile.new(:bomb)
    end
  end

  def bomb_positions
    positions = []
    until positions.length == @num_bombs
      pos = [rand(BOARD_SIZE), rand(BOARD_SIZE)]
      positions << pos unless positions.include?(pos)
    end
    positions
  end
end

class Tile
  attr_reader :value, :visible, :flagged

  def initialize(value)
    @visible = false
    @flagged = false
    @value = value
  end

  def flip
    @visible = true
  end

  def toggle_flag
    @flagged = flagged == true ? false : true
  end

end

class Minesweeper

  attr_reader :board


  def initialize(num_bombs)
    @board = Board.new(num_bombs)
  end





  def play
    board.render
  end


end
