require_relative 'tile.rb'
require 'byebug'


class Board
  attr_reader :grid


  def initialize(size = 9, bomb_count = 10)
    @grid = Array.new(size) { Array.new(size) }
    @size = size
    @bomb_count = bomb_count
  end

  def populate_board
    values = Array.new(@size**2 - @bomb_count)
    values.concat(Array.new(@bomb_count) {:bomb})
    values.shuffle!

    @grid.each_with_index do |row, row_i|
      row.each_with_index do |col, col_i|
        value = values.pop
        pos = [row_i,col_i]
        self[pos]= Tile.new(value,pos,self)
      end
    end

    # self.populate_numbers

  end

  def populate_numbers
    debugger
    @grid.each_with_index do |row, row_i|
      row.each_with_index do |col, col_i|
        pos = [row_i,col_i]
        self[pos].neighbor_bomb_count
      end
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @grid[row][col] = val
  end


end
