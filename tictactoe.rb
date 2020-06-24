require 'io/console'


# Tic-Tac-Toe Board Display
class Board
  def initialize
    @view = []
    for i in 0..4
      if i.odd?
        @view += ['-----------']
      else
        @view += ['   |   |   ']
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
      column = 1
    when 2, 5, 8
      column = 5
    when 3, 6, 9
      column = 9

    end

    @view[row][column] = mark
  end

  def display_view
    puts @view
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
      puts "please choose which square you would like to mark (1-9), #{self.name}"
      location = STDIN.noecho(&:gets).chomp.to_i
    end
    add_moves(location)
    puts "you chose square ##{location}, #{self.name}"
    return location
  end

  def add_moves(location)
    @moves.push(location)
  end
end

class Game
  WIN_CONDITIONS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  def initialize
    @player1 = Player.new('player 1', 'X')
    @player2 = Player.new('player 2', 'O')
    @board = Board.new
    @all_moves = []
  end

  def update_choices(player, location)
    player.add_moves(location)
    @all_moves.push(location)
  end

  def win_check(player)
    WIN_CONDITIONS.any? { |win_cond| (win_cond - player.moves) == [] }
  end

  def start_game
    for i in 0..8
      if i.even?
        current = @player1
      else
        current = @player2
      end

      @board.display_view

      location = current.move
      until !@all_moves.include? location
        puts ''
        puts 'That square has already been marked, try again'
        @board.display_view
        location = current.move
      end

      update_choices(current, location)
      @board.update_view(location, current.mark)
      if win_check(current)
        puts ''
        puts "congratulations! #{current.name} wins!"
        break
      end
      puts ''
    end
    @board.display_view
  end
end

x = Game.new
x.start_game
