# Tik-Tac-Toe 
OOP with four classes: Board, GuideBoard Player, Game

# Board:
Allows for instantiation of a typical board display, with methods to adjust and    display the board.

# GuideBoard:
Allows for instantiation of a board that guides players on what numbers to select when marking a spot, with a method to display the board.

# Player:
Allows for instantiation of a player with a name and marker, along with methods to make a move (mark a spot), and add move to an array of player's moves. Also uses attr_reader to allow for access of player's name, marker, and moves made.

# Game:
Establishes constant win conditions and tie condition, instantiates two players (p1 (X) and p2 (O)), a new board, a new guideboard, and a array for storing all of the moves by player1 and player2. Methods include updating all moves, checking for game-winning conditions and a tie condition, and starting a new game.
