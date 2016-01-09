class Tile
  attr_reader :value, :revealed
  attr_writer :board

  RELATIVE_NEIGHBORS_POS = [
    [-1,-1], [-1, 0], [-1,1],
    [0,-1], [0,1],
    [1,-1], [1,0], [1,1]
  ]

  def initialize(value, pos, board = nil)
    @value = value
    @pos = pos
    @board = board

    @revealed = false
    @flagged = false
  end

  def revealed?
    @revealed
  end

  def flagged?
    @flagged
  end

  def reveal
    return if @flagged || @revealed
    @revealed = true
    @value
  end

  def toggle_flag
    @flagged = !@flagged
  end

  def bomb?
    @value == :B && @revealed
  end

  def neighbors
    actual_neighbors_pos = []

    RELATIVE_NEIGHBORS_POS.each do |n_pos|
      actual_neighbors_pos << @pos.zip(n_pos).map {|el| el.inject(:+)}
    end

    valid_positions(actual_neighbors_pos)
  end

  def valid_positions(position_array)
    # debugger
    position_array.select do |pos|
      pos.all? { |el| el.between?(0, @board.size - 1) }
    end
  end

  def inspect
    { 'value' => @value, 'position' => @pos,  }.inspect
  end

  def neighbor_bomb_count
    return if @value == :B

    bomb_count = 0
    self.neighbors.each do |n_pos|
      bomb_count += 1 if @board[n_pos].value == :B
    end

    @value = bomb_count unless bomb_count.zero?
  end

end
