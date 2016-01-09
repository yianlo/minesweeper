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
    until won? || lost?
      @board.render
      pos, click = prompt_user

      case click
      when "right"
        self.right_clicked(pos)
      when "left"
        self.left_clicked(pos)
      end
    end
    @board.render

    puts "Congratulations, you won!"  if won?
    puts "That was a bomb! You lose" if lost?
  end

  def prompt_user
    puts "Where would you like to click?"
    pos = gets.chomp.split(", ").map(&:to_s)
    puts "Left or Right click?"
    click = gets.chomp.downcase

    [pos, click]
  end

end
