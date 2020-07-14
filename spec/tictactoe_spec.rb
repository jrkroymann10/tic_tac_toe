# spec/tictactoe_spec.rb
require './lib/tictactoe'

describe Board do
  it 'creates an array of 5 arrays, used to display the game' do
    board = Board.new
    expect(board.view.length).to eql(5)
  end
end

describe Game do
  describe '#win_check' do
    game = Game.new
    player = Player.new('Joe', 'x')
    it 'returns true if a player has a vertical win condition' do
      player.moves = [1, 4, 7]
      expect(game.win_check(player)).to eql(true)
    end

    it 'returns true if a player has a horizontal win condition' do
      player.moves = [1, 2, 3]
      expect(game.win_check(player)).to eql(true)
    end

    it 'returns true if a player has a diagonal win condition' do
      player.moves = [1, 5, 9]
      expect(game.win_check(player)).to eql(true)
    end

    it 'identifies a win condition from more than 3 moves' do
      player.moves = [1, 5, 3, 2]
      expect(game.win_check(player)).to eql(true)
    end

    it 'returns false if a player does not have a win condition' do
      player.moves = [1, 3, 5, 6]
      expect(game.win_check(player)).to eql(false)
    end
  end

  describe '#tie_check' do
    game = Game.new
    it 'returns true if the board is full' do
      game.all_moves = [1, 2, 3, 4, 5, 6, 7, 8, 9]
      expect(game.tie_check).to eql(true)
    end

    it "returns false if the board isn't full" do
      game.all_moves = [1, 2, 3, 4, 5, 6, 7, 8]
      expect(game.tie_check).to eql(false)
    end
  end
end
