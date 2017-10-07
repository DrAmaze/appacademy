class KnightPathFinder
  VALID_MOVES = [
    [2,1]
    [2,-1]
    [1,2]
    [-1,2]
    [1,-2]
    [-1,-2]
    [-2,-1]
    [-2,1]
  ]

  def self.valid_moves(pos)
    possible_moves = []
    VALID_MOVES.each do |move|
      possible_moves <<
    end
  end

  def initialize(start_pos)
    @visited_positions = [start_pos]
  end

  def new_move_positions(pos)
    move_set = self.valid_moves(pos)
    move_set.select { |move| valid_move?(move) }
  end

  def valid_move?(pos)
    return true if (0...8).include?(pos[0]) && (0...8).include?(pos[1])
    false
  end

end
