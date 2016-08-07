require './lib/pieces/rook'
require './lib/pieces/knight'
require './lib/pieces/bishop'
require './lib/pieces/queen'
require './lib/pieces/king'
require './lib/pieces/pawn'

class GamePieces
  attr_accessor :black_symbols, :white_symbols, :all_symbols

  def initialize
    b_rook1, b_rook2     = Rook.new(1, 8, "black"),   Rook.new(8, 8, "black")
    b_knight1, b_knight2 = Knight.new(2, 8, "black"), Knight.new(7, 8, "black")
    b_bishop1, b_bishop2 = Bishop.new(3, 8, "black"), Bishop.new(6, 8, "black")
    b_queen, b_king      = Queen.new(4, 8, "black"),  King.new(5, 8, "black")
    b_pawn1, b_pawn2     = Pawn.new(1, 7, "black"),   Pawn.new(2, 7, "black")
    b_pawn3, b_pawn4     = Pawn.new(3, 7, "black"),   Pawn.new(4, 7, "black")
    b_pawn5, b_pawn6     = Pawn.new(5, 7, "black"),   Pawn.new(6, 7, "black")
    b_pawn7, b_pawn8     = Pawn.new(7, 7, "black"),   Pawn.new(8, 7, "black")

    w_rook1, w_rook2     = Rook.new(1, 1, "white"),   Rook.new(8, 1, "white")
    w_knight1, w_knight2 = Knight.new(2, 1, "white"), Knight.new(7, 1, "white")
    w_bishop1, w_bishop2 = Bishop.new(3, 1, "white"), Bishop.new(6, 1, "white")
    w_queen, w_king      = Queen.new(4, 1, "white"),  King.new(5, 1, "white")
    w_pawn1, w_pawn2     = Pawn.new(1, 2, "white"),   Pawn.new(2, 2, "white")
    w_pawn3, w_pawn4     = Pawn.new(3, 2, "white"),   Pawn.new(4, 2, "white")
    w_pawn5, w_pawn6     = Pawn.new(5, 2, "white"),   Pawn.new(6, 2, "white")
    w_pawn7, w_pawn8     = Pawn.new(7, 2, "white"),   Pawn.new(8, 2, "white")

    @black_symbols = [b_rook1, b_rook2, b_knight1, b_knight2,
                      b_bishop1, b_bishop2, b_queen, b_king,
                      b_pawn1, b_pawn2, b_pawn3, b_pawn4,
                      b_pawn5, b_pawn6, b_pawn7, b_pawn8
                      ]

    @white_symbols = [w_rook1, w_rook2, w_knight1, w_knight2,
                      w_bishop1, w_bishop2, w_queen, w_king,
                      w_pawn1, w_pawn2, w_pawn3, w_pawn4,
                      w_pawn5, w_pawn6, w_pawn7, w_pawn8
                      ]

    @all_symbols   = @black_symbols + @white_symbols

=begin CHECKMATE TESTS
    # ---- Checkmate with Two Major Pieces (Rook and Queen) 
    # a6 a8
    @all_symbols = [
      King.new(6,8,"black"),
      King.new(4,1,"white"),
      Queen.new(1,6,"white"),
      Rook.new(2,7,"white")
    ]
#=end
#=begin
    # ---- Back Rank Mate
    # a2 a3
    # c6 c1
    @all_symbols = [
      King.new(5,8,"black"),
      King.new(7,1,"white"),
      Rook.new(3,6,"black"),
      Pawn.new(6,2,"white"),
      Pawn.new(7,2,"white"),
      Pawn.new(8,2,"white"),
      Pawn.new(1,2,"white"),
    ]
#=end
#=begin
    # ---- Queen and Knight
    # h7 e7
    @all_symbols = [
      King.new(5,8,"black"),
      King.new(5,1,"white"),
      Queen.new(8,7,"white"),
      Knight.new(6,5,"white")
    ]
#=end
#=begin
    # ---- Queen and Bishop
    # a2 a3
    # c6 g2
    @all_symbols = [
      King.new(5,8,"black"),
      King.new(7,1,"white"),
      Queen.new(3,6,"black"),
      Bishop.new(2,7,"black"),
      Pawn.new(6,2,"white"),
      Pawn.new(7,2,"white"),
      Pawn.new(8,2,"white"),
      Pawn.new(1,2,"white"),
      Rook.new(6,1, "white"),
      Pawn.new(1,2,"white"),
    ]
#=end
#=begin
    # ---- Mate With Two Bishops
    # a2 a3
    # e6 d5
    @all_symbols = [
      King.new(7,8,"black"),
      King.new(8,1,"white"),
      Pawn.new(8,2,"white"),
      Pawn.new(1,2,"white"),
      Bishop.new(4,4,"black"),
      Bishop.new(5,6,"black"),
    ]
#=end
#=begin
    # ---- Checkmating With a Bishop and Knight
    # a2 a3
    # g5 h3
    @all_symbols = [
      King.new(7,8,"black"),
      King.new(7,1,"white"),
      Knight.new(7,5,"black"),
      Bishop.new(6,3,"black"),
      Pawn.new(6,2,"white"),
      Pawn.new(7,3,"white"),
      Pawn.new(8,2,"white"),
      Pawn.new(1,2,"white"),
      Rook.new(6,1, "white"),
    ]
#=end
#=begin
    # ---- A King and Pawn Checkmate
    # c6 c7
    @all_symbols = [
      King.new(4,8,"black"),
      King.new(4,6,"white"),
      Pawn.new(4,7,"white"),
      Pawn.new(3,6,"white"),
      Pawn.new(8,4,"black"),
    ]
#=end
#=begin
    # ---- Smothered Mate
    # a2 a3
    # g4 f2
    @all_symbols = [
      King.new(7,8,"black"),
      King.new(8,1,"white"),
      Pawn.new(7,2,"white"),
      Pawn.new(8,2,"white"),
      Rook.new(7,1,"white"),
      Knight.new(7,4,"black"),
      Pawn.new(1,2,"white")
    ]
#=end
#=begin
    # ---- Anastasia's Mate
    # d3 h3
    @all_symbols = [
      King.new(8,7,"black"),
      King.new(8,1,"white"),
      Rook.new(4,3,"white"),
      Knight.new(5,7,"white"),
      Pawn.new(6,7,"black"),
      Pawn.new(7,7,"black"),
      Rook.new(6,8,"black")
    ]
=end
#=begin
    # ---- Morphy's Mate
    # e7 f6
    @all_symbols = [
      King.new(8,8,"black"),
      King.new(2,1,"white"),
      Rook.new(7,1,"white"),
      Bishop.new(5,7,"white"),
      Pawn.new(8,7,"black"),
      Pawn.new(6,7,"black"),
    ]
#=end
  end
end