require_relative 'tile.rb'
require 'byebug'


class Board
  attr_reader :grid, :size, :bomb_count


  def initialize(size = 9, bomb_count = 10)
    @grid = Array.new(size) { Array.new(size) }
    @size = size
    @bomb_count = bomb_count
    populate
  end

  def populate
    self.populate_bomb
    self.populate_numbers
  end

  def populate_bomb
    values = Array.new(@size**2 - @bomb_count)
    values.concat(Array.new(@bomb_count) {:B})
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
    # debugger
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

  def render

    # debugger
    system("clear")
    puts "  #{(0...@size).to_a.join(" ")}"
    @grid.each_with_index do |row, row_i|
      row_str = "#{row_i} "

      row.each_with_index do |col, col_i|
        val = self[[row_i,col_i]].value
        revealed = self[[row_i,col_i]].revealed?
        flagged = self[[row_i,col_i]].flagged?

        if revealed
          val.nil? ? row_str <<  "x " : row_str << "#{val} "
        elsif flagged
          row_str <<  "F "
        else
          row_str << "  "
        end
      end

      puts row_str
    end
  end

end
