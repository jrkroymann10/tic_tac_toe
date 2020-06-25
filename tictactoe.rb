require 'io/console'


# Tic-Tac-Toe Board Display
class Board
  def initialize
    @view = []
    for i in 0..4
      if i.odd?
        @view += ['   -----------']
      else
        @view += ['      |   |   ']
      end
    end
  end

  def update_view(spot, mark)
    row = 0
    column = 0

    case spot
    when 1..3
      row = 0
    when 4..6
      row = 2
    when 7..9
      row = 4

    end

    case spot
    when 1, 4, 7
      column = 4
    when 2, 5, 8
      column = 8
    when 3, 6, 9
      column = 12

    end

    @view[row][column] = mark
  end

  def display_view
    puts @view
  end
end

# Board w/number guide
class GuideBoard
  def initialize
    @guide_view = []
    for i in 0..4
      if i.odd?
        @guide_view += ['   -----------']
      else
        @guide_view += ['      |   |   ']
      end
    end
    start = 0
    for i in 0..4
      if i.even?
        @guide_view[i][4] = (start + 1).to_s
        @guide_view[i][8] = (start + 2).to_s
        @guide_view[i][12] = (start + 3).to_s
        start += 3
      end
    end
  end


  def view_guide
    puts @guide_view
  end
end

# Player
class Player
  attr_reader :name, :mark, :moves
  def initialize(name, mark)
    @name = name
    @mark = mark
    @moves = []
  end

  def move
    location = 0
    until location > 0 && location < 10
      print "your move, #{self.name}: "
      location = gets.chomp.to_i
      puts ''
    end
    add_moves(location)
    return location
  end

  def add_moves(location)
    @moves.push(location)
  end
end

class Game
  WIN_CONDITIONS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  TIE_CONDITION = [[1, 2, 3, 4, 5, 6, 7, 8, 9]]
  def initialize
    @player1 = Player.new('p1', 'X')
    @player2 = Player.new('p2', 'O')
    @board = Board.new
    @guide_board = GuideBoard.new
    @all_moves = []
  end

  def update_choices(player, location)
    player.add_moves(location)
    @all_moves.push(location)
  end

  def win_check(player)
    WIN_CONDITIONS.any? { |win_cond| (win_cond - player.moves) == [] }
  end

  def tie_check(player)
    TIE_CONDITION.any? { |tie_cond| (tie_cond - player.moves) == [] }
  end

  def start_game
    for i in 0..8
      if i.even?
        current = @player1
      else
        current = @player2
      end

      if i == 0 
        puts ''
        puts 'welcome to tic-tac-toe! use the board below as a guide on how to move.'
        puts ''
        @guide_board.view_guide 
        puts ''
      end

      location = current.move
      while @all_moves.include? location
        puts 'already marked, try again'
        puts ''
        @board.display_view
        puts ''
        location = current.move
      end

      update_choices(current, location)
      @board.update_view(location, current.mark)
      @board.display_view
      if win_check(current)
        puts ''
        puts "congratulations! #{current.name} wins!"
        break
      elsif tie_check(current)
        puts ''
        puts "it's a tie, play again!"
        break
      end
      puts ''
    end
  end
end

x = Game.new
x.start_game
