class Tile

  def initialize(value=0)
    @value = value
    given = true if value == 0
  end

  def to_s

  end
end

class Board

  def initialize(grid)
    @grid = grid
  end

  def self.from_file
    @grid = File.readlines("sudoku1.txt").map(&:chomp)
  end

  def update_tile(position_arr, value)
    @grid[position_arr[0]][position_arr[1]] = value
  end

  def render
    @grid.each do |row|
      row.each { |col| p col}
    end
  end

  def solved?
    @grid.flatten.any? { |tile| tile == 0}
  end

  def row_solved?(row_arr)
    row_arr.sort == (1..9)
  end

  def col_solved?(col_pos) #first column is given value of 1
    i = 0
    col = []
    while i < 9
      col << @grid[i][col_pos - 1]
      i += 1
    end
    col.sort == (1..9)
  end

end
