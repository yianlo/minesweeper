class Tile

  POSSIBLE_NEIGHBORS = [
    [-1,-1], [-1, 0], [-1,1],
    [0,-1], [0,1],
    [1,-1], [1,0], [1,1]
  ]


  def initialize(value)
    @value = value
    @revealed = false
    @flagged = false
  end

  def revealed?
    @revealed
  end

  def reveal
    if @flagged
      return
    else
      @revealed
    end
  end

  def toggle_flag
    !@flagged
  end

  def bomb?
    @value == :bomb && @revealed
  end

  def neighbors
    actual_neighbors = []

    POSSIBLE_NEIGHBORS.each do |n_pos|
      actual_neighbors << @pos.zip(n_pos).map {|el| el.inject(:+)}
    end

    @neighbors = valid_neighbors(actual_neighbors)
  end

  def valid_neighbors(position_array)
    # debugger
    position_array.select do |pos|
      pos.all? { |el| el >= 0 && el < 9 }
    end
  end

  def neighbor_bomb_count
    bomb_count = 0

    # @neighbors.each do |n_pos|
    #
    # end
  
    @value = bomb_count
  end

end
