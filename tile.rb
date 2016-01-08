class Tile
  attr_reader :value

  RELATIVE_NEIGHBORS_POS = [
    [-1,-1], [-1, 0], [-1,1],
    [0,-1], [0,1],
    [1,-1], [1,0], [1,1]
  ]


  def initialize(value, pos, board)
    @value = value
    @pos = pos
    @board = board

    @revealed = false
    @flagged = false
  end

  def revealed?
    @revealed
  end

  def reveal
    return if @flagged || @revealed

    @value
  end

  def toggle_flag
    !@flagged
  end

  def bomb?
    @value == :bomb && @revealed
  end

  def neighbors
    actual_neighbors_pos = []

    RELATIVE_NEIGHBORS_POS.each do |n_pos|
      actual_neighbors_pos << @pos.zip(n_pos).map {|el| el.inject(:+)}
    end

    @neighbors_pos = valid_positions(actual_neighbors_pos)
  end

  def valid_positions(position_array)
    # debugger
    position_array.select do |pos|
      pos.all? { |el| el >= 0 && el < 9 }
      #{ |coord| coord.between?(0, 7) }
    end
  end

  def neighbor_bomb_count
    bomb_count = 0

    @neighbors_pos.each do |n_pos|
      bomb_count += 1 if board[n_pos].value == :bomb
    end

    @value = bomb_count unless bomb_count.zero?
  end

end
