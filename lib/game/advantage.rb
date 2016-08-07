class Advantage
  attr_accessor :kings_unsafe_moves, 
                :potential_threats, :current_threats, :threat_attackers,
                :actions

  def initialize
    @kings_unsafe_moves  = []
    @potential_threats   = []
    @current_threats     = []
    @threat_attackers    = []

    @actions             = BasicActions.new
  end

  # user_king_location takes a hash {x: , y: }
  def check?(opponent_pieces, user_king_location, all_pieces)
    status = false

    opponent_pieces.each do |piece|
      origin      = piece.data[:coordinates]
      destination = user_king_location

      if piece.valid_move?(origin, destination, all_pieces)
        piece.data[:check] = true
        status             = true
      else
        piece.data[:check] = false
      end
    end

    status
  end

  def checkmate?(user_pieces, opponent_pieces, all_pieces)
    
    find_current_threats(user_pieces, opponent_pieces, all_pieces)

    puts "can king evade ?"
    puts king_evade?(user_pieces, opponent_pieces, all_pieces)
    find_potential_threats(opponent_pieces, all_pieces)

    puts "can user beat threat? w/o dying"
    puts beat_threat?(user_pieces, opponent_pieces, all_pieces)

    puts "can user block threat? w/o dying"
    puts 

    
    #1. checkmate? is false if: #king_evade?    is true     -> finished
    #2. checkmate? is false if: #beat_threat?   is true
    #3. checkmate? is false if: #block_threat?  is true
    #4. else checkmate? is true

  end

  def king_evade?(user_pieces, opponent_pieces, all_pieces)
    king_origin      = find_king(user_pieces)
    valid_king_moves = empty_king_moves(king_origin, user_pieces, opponent_pieces)

    valid_king_moves.each do |king_coord|
      target = all_pieces.select{ |piece| piece[:coordinates] == king_origin }
      target[0][:coordinates] = king_coord 
      
      if check?(opponent_pieces, king_coord, all_pieces)
        @kings_unsafe_moves << king_coord
      end

      target[0][:coordinates] = king_origin
    end

    (valid_king_moves - @kings_unsafe_moves).length > 0
  end

  def beat_threat?(user_pieces, opponent_pieces, all_pieces)
    if @current_threats.empty?
      true
    elsif @current_threats.size == 1
     find_threat_attackers(user_pieces, all_pieces)
     status = true
     safely_capture = []

     @threat_attackers.each do |piece|
        destination = @current_threats[0].data[:coordinates]

        origin      = piece.data[:coordinates]
        king_origin = find_king(user_pieces)
        
        actions.move_piece(origin, destination, all_pieces)
        if check?(opponent_pieces ,king_origin, all_pieces)
          safely_capture << piece
        end
        actions.move_piece(destination, origin, all_pieces)
      end

      status = safely_capture == [] ? false : status
      status
    elsif @current_threats.size > 1
      king_origin = find_king(user_pieces)
      king_piece  = user_pieces.select{ |i| i.data[:name] == "king" }
      king_piece  = king_piece[0]
      status      = true

      @current_threats.each do |threat|
        destination = threat.data[:coordinates]

        if king_piece.valid_move?(king_origin, destination)
        actions.move_piece(king_origin, destination, all_pieces)
        temp_king_location = find_king(user_pieces)
        
        status = false if check?(opponent_pieces, temp_king_location, all_pieces)

        actions.move_piece(destination, king_origin, all_pieces)
        end
      end
      
      status
    end
  end

  def block_threat?
  end

  def find_potential_threats(opponent_pieces, all_pieces)
    opponent_pieces.each do |piece|
      origin = piece.data[:coordinates]
      kings_unsafe_moves.each do |coord|
        if piece.valid_move?(origin, coord, all_pieces)
          @potential_threats << piece
        end
      end
    end
  end

  def find_current_threats(user_pieces, opponent_pieces, all_pieces)
    opponent_pieces.each do |piece| 
      origin      = piece.data[:coordinates]
      king_origin = find_king(user_pieces)
      
      if piece.valid_move?(origin, king_origin, all_pieces)
        @current_threats << piece
      end
    end
  end

  def find_threat_attackers(user_pieces, all_pieces)
    user_pieces.each do |piece|
      destination = @current_threats[0].data[:coordinates]
      origin      = piece.data[:coordinates]

      if piece.valid_move?(origin, destination, all_pieces)
        @threat_attackers << piece
      end
    end
  end

  def empty_king_moves(king_origin, user_pieces, opponent_pieces)
    x, y = king_origin[:x], king_origin[:y]

    possible_king_moves = [
      {x:x-1, y:y-1}, {x:x, y:y-1}, {x:x+1, y:y-1},
      {x:x-1, y:y  }, {x:x+1, y:y},
      {x:x-1, y:y+1}, {x:x, y:y+1}, {x:x+1, y:y+1}
    ]

    valid_king_moves  = 
      possible_king_moves.select do |coord| 
        ( (1..8).include? coord[:x] ) && ( (1..8).include? coord[:y] )
      end

    user_piece_coords = user_pieces.map{ |i| i.data[:coordinates] }
    opponent_coords   = opponent_pieces.map{ |i| i.data[:coordinates] }
    
    valid_king_moves.delete_if do |coord| 
      (user_piece_coords.include? coord) || (opponent_coords.include? coord)
    end
    return valid_king_moves
  end

  def kings_unsafe_moves
    @kings_unsafe_moves.uniq
  end

  def potential_threats
    @potential_threats.uniq
  end

  def find_king(user_pieces)
    king_piece  = user_pieces.select{ |i| i.data[:name] == "king" }
    king_piece  = king_piece[0]
    king_origin = king_piece.data[:coordinates]
  end



# ---------------------------------

  def stalemate?
    # stalemate? is true if player cannot move without being in check
  end
end


=begin 

execute at start of every turn

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

    

=end