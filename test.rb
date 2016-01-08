def valid_neighbors(position_array)
  debugger
  position_array.select do |pos|
    pos.all? { |el| el >= 0 || el < 9 }
  end
end
