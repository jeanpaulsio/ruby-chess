class Advantage
  def check?(player_pieces, destination, all_pieces)
    status = false
    player_pieces.each do |piece|
      origin = piece.data[:coordinates]
      
      if piece.valid_move?(origin, destination, all_pieces)
        piece.data[:check] = true
        status             = true
      else
        piece.data[:check] = false
      end
    end
    status
  end

  def checkmate?(player_pieces, all_pieces)
    status = false

    king_piece = player_pieces.select{ |i| i.data[:name] == "king" }
    coord = king_piece[0].data[:coordinates]

    possible_king_moves = []

    puts "#{king_piece[0].data[:color]} #{king_piece[0].data[:name]}"
    puts "#{king_piece[0].data[:coordinates]}"
    puts "checkmate: #{status}"



    status
  end

  def stalemate?
  end
end


=begin 
exclude if x == 0 || x == 9 || y == 0 || y == 9

{x:4, y:0}
{x:5, y:0}
{x:6, y:0}

{x:4, y:1}
{x:5, y:1} ***
{x:6, y:1}

{x:4, y:2}
{x:5, y:2}
{x:6, y:2}





is current player in checkmate? **CURRENT PLAYER** 

checkmate? implementations
execute only if in check
1. if single check (one threat)
  ***can threat be captured? w/o still being in check if not, then....
    - threat = destination
    - iterate thru each piece(incl. king). set to origin
    - origin -> destination is_valid?
    - is_valid: then set checkmate to false
    - isnt_vald: then check next

    -capturing can NOT result in being in check
  ***can threat be blocked? if not, then....
    - find path from threat to king
    - skip this step if threat == rook or pawn
    - check all pieces against path to king
  ***can king move out of way?
    - find all possible king moves
    - can king move without being in check

2. if double check (two threats)
    -king MUST move
    -check all possible king moves
    -checkmate if ALL possible moves lead to check

=end