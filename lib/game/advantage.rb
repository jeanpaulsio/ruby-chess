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

  def checkmate?(player_pieces, opponent_pieces, all_pieces)
    king_piece       = player_pieces.select{ |i| i.data[:name] == "king" }
    valid_king_moves = find_king_moves(king_piece)




    #1. checkmate? is false if king can move safely
    #2. checkmate? is false if threat can be eaten safely
    #3. checkmate? is false if threat can be blocked safely
    #4. else checkmate? is true
  end

  def find_king_moves(king_piece)
    x, y = king_piece[0].data[:coordinates][:x], king_piece[0].data[:coordinates][:y]

    possible_king_moves = [
      {x:x-1, y:y-1}, {x:x, y:y-1}, {x:x+1, y:y-1},
      {x:x-1, y:y  }, {x:x, y:y  }, {x:x+1, y:y  },
      {x:x-1, y:y+1}, {x:x, y:y+1}, {x:x+1, y:y+1}
    ]

    valid_king_moves = 
      possible_king_moves.select do |coord|
        ( (1..8).include? coord[:x] ) && ( (1..8).include? coord[:y] )
      end

    return valid_king_moves
  end


  



=begin
  def checkmate?(player_pieces, opponent_pieces, all_pieces)

    king_piece = player_pieces.select{ |i| i.data[:name] == "king" }
    valid_king_moves = find_king_moves(king_piece)

    king_piece_coord = king_piece[0].data[:coordinates]
    

    
    # ----- find threat to the king; see if you can capture it.
    threat = opponent_pieces.select{ |i| i.data[:check] == true }
    threat_coord = threat[0].data[:coordinates] unless threat.empty?

    threat_beaters = player_pieces.select do |piece|
      origin = piece.data[:coordinates]
      piece.valid_move?(origin, threat_coord, all_pieces) unless threat_coord.nil?
    end

    mock_threat_beaters = threat_beaters.clone
    mock_player_pieces = player_pieces.clone

    mock_opponent_pieces = opponent_pieces.clone
    mock_all_pieces = all_pieces.clone
  
    mock_opponent_pieces.delete_if do |piece|
      piece.data[:check] ||
      piece.data[:name] == "king"
    end

    mock_all_pieces.delete_if do |piece|
      piece[:check]
    end

    mock_threat_beaters.delete_if do |piece|
      piece.data[:name] == "king"
    end


    a = mock_threat_beaters.each do |piece|
      original = piece.data[:coordinates]
      piece.data[:coordinates] = threat_coord
      
      p piece
      status = mock_opponent_pieces.any? do |i|

        origin = i.data[:coordinates]
        destination = king_piece_coord

        puts "#{origin} -> #{destination}"
        puts 'valid_move?:'
        puts piece.valid_move?(origin, king_piece_coord, mock_all_pieces)
      end

      puts "status: "
      puts status
      piece.data[:coordinates] = original
    end

    puts a


    #puts "u can beat it" if threat_is_beatable
    # ----- eliminate threat to king; are you still in check?

    p "mock opponent pieces: #{mock_opponent_pieces.join(' ')}"


    # -----
    
    puts "threat at: #{threat_coord}"
    puts "your king at : #{king_piece[0].data[:coordinates]}"

    #puts "your king moves: #{valid_king_moves.join(", ")}"
    #puts "checkmate: #{status}"

    #status
  end
=end


  def stalemate?
  end
end


=begin 

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