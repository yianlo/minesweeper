require_relative 'board'
require_relative 'tile'

class Game
  def initialize(board = Board.new(9,9))
    @board = board
    @non_bomb_tiles = 0
  end


  def lost?(pos)
    @board[pos].bomb?
  end

  def won?
    @non_bomb_tiles == @board.size ** 2 - @board.bomb_count
  end


  def play
    until won?
      @board.render
      pos, click = prompt_user

      case click
      when "right"
        self.right_clicked(pos)
      when "left"
        self.left_clicked(pos)
      end

      break if lost?(pos)
    end

    @board.render
    puts "Congratulations, you won!"  if won?
    puts "That was a bomb! You lose" if lost?(pos)

  end

  def prompt_user
    puts "Where would you like to click?"
    pos = gets.chomp.split(", ").map(&:to_i)
    puts "Left or Right click?"
    click = gets.chomp.downcase

    [pos, click]
  end

  def right_clicked(pos)
    @board[pos].toggle_flag
  end

  def left_clicked(pos)
    return if @board[pos].flagged? #clicked on flagged tile
    # @board[pos].reveal unless @board[pos].value.nil? #clicked on number or bomb tile
    # reveal_nils(pos) if @board[pos].value.nil? #clicked on nil tile
    @board[pos].value.nil? ? reveal_nils(pos) : @board[pos].reveal

  end

  def reveal_nils(pos)
    queue = [pos]

    until queue.empty?
      current_pos = queue.shift

      queue.concat(@board[current_pos].neighbors) if @board[current_pos].value.nil? && !@board[current_pos].revealed? 
      @board[current_pos].reveal

    end
  end


end
