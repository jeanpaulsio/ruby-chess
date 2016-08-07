require './lib/pieces/rook'
require './lib/pieces/knight'
require './lib/pieces/bishop'
require './lib/pieces/queen'
require './lib/pieces/king'
require './lib/pieces/pawn'

class GamePieces
  attr_accessor :black_symbols, :white_symbols, :all_symbols

  def initialize
    @black_rook1, @black_rook2     = Rook.new(1, 8, "black"),   Rook.new(8, 8, "black")
    @black_knight1, @black_knight2 = Knight.new(2, 8, "black"), Knight.new(7, 8, "black")
    @black_bishop1, @black_bishop2 = Bishop.new(3, 8, "black"), Bishop.new(6, 8, "black")
    @black_queen, @black_king      = Queen.new(4, 8, "black"),  King.new(5, 8, "black")
    @black_pawn1, @black_pawn2     = Pawn.new(1, 7, "black"),   Pawn.new(2, 7, "black")
    @black_pawn3, @black_pawn4     = Pawn.new(3, 7, "black"),   Pawn.new(4, 7, "black")
    @black_pawn5, @black_pawn6     = Pawn.new(5, 7, "black"),   Pawn.new(6, 7, "black")
    @black_pawn7, @black_pawn8     = Pawn.new(7, 7, "black"),   Pawn.new(8, 7, "black")

    @white_rook1, @white_rook2     = Rook.new(1, 1, "white"),   Rook.new(8, 1, "white")
    @white_knight1, @white_knight2 = Knight.new(2, 1, "white"), Knight.new(7, 1, "white")
    @white_bishop1, @white_bishop2 = Bishop.new(3, 1, "white"), Bishop.new(6, 1, "white")
    @white_queen, @white_king      = Queen.new(4, 1, "white"),  King.new(5, 1, "white")
    @white_pawn1, @white_pawn2     = Pawn.new(1, 2, "white"),   Pawn.new(2, 2, "white")
    @white_pawn3, @white_pawn4     = Pawn.new(3, 2, "white"),   Pawn.new(4, 2, "white")
    @white_pawn5, @white_pawn6     = Pawn.new(5, 2, "white"),   Pawn.new(6, 2, "white")
    @white_pawn7, @white_pawn8     = Pawn.new(7, 2, "white"),   Pawn.new(8, 2, "white")

    @black_symbols = [@black_rook1, @black_rook2, @black_knight1, @black_knight2,
                      @black_bishop1, @black_bishop2, @black_queen, @black_king,
                      @black_pawn1, @black_pawn2, @black_pawn3, @black_pawn4,
                      @black_pawn5, @black_pawn6, @black_pawn7, @black_pawn8
                      ]

    @white_symbols = [@white_rook1, @white_rook2, @white_knight1, @white_knight2,
                      @white_bishop1, @white_bishop2, @white_queen, @white_king,
                      @white_pawn1, @white_pawn2, @white_pawn3, @white_pawn4,
                      @white_pawn5, @white_pawn6, @white_pawn7, @white_pawn8
                      ]

    @all_symbols   = @black_symbols + @white_symbols
    
    # ---- test
    #@white_queen = Queen.new(6,8, "white")
    #@white_rook2 = Rook.new(8,6, "white")
    #@white_rook1 = Rook.new(8,1, "white")
    #@black_queen = Queen.new(1, 2, "black")
    #@black_king = King.new(8, 8, "black")
    @all_symbols = [@black_king, @black_queen, @white_queen, @white_king, @white_rook1, @white_rook2, @black_rook1]
  end
end