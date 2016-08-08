require_relative 'player'
require_relative 'board'
require_relative 'game_pieces'
require_relative 'instructions'
require_relative 'messages'
require_relative 'advantage'          # check, checkmate, stalemate

require './lib/pieces/basic_actions'
require './lib/pieces/special_moves'

class Play
  attr_reader :actions, :advantage, :current_msg,
              :gamepieces, :messages, :special

  def initialize
    @game         = Board.new
  
    @gamepieces   = GamePieces.new
    @player1      = Player.new("white")
    @player2      = Player.new("black")
    
    @special      = SpecialMoves.new
    @actions      = BasicActions.new
    @advantage    = Advantage.new
    
    @instructions = Instructions.new
    @messages     = Messages.new
    @current_msg  = messages.blank

    play_game(@player1)
  end

  def play_game(player)
    display_board
    end_game if player_in_mate?(player)
    player_in_check?(player)

    display_message(player)

    answer      = player.take_turn
    parsed_ans  = scan_answer(answer)
    invalid_input?(parsed_ans, player)

    user_input  = parsed_ans[0][0].split("")
    origin      = { x: user_input[0].ord  - 96, y: user_input[1].to_i }
    destination = { x: user_input[-2].ord - 96, y: user_input[-1].to_i }

    if parsed_ans[0].include? " castle"
      opponent_pieces = get_pieces_for(player, opponent=true)
      
      if player_in_check?(player)
        @current_msg = messages.invalid_castle_check
        error_loop(player)
      elsif !special.valid_castle?(origin, destination, opponent_pieces, all_pieces)
        @current_msg = messages.invalid_castle_normal
        error_loop(player)
      end
      reset_advantage_arrays
      switch_players(player)
    elsif parsed_ans[0].include? " promote"


      reset_advantage_arrays
      switch_players(player)
    else
      game_loop(origin, destination, player)
    end

  end

  def make_move(origin, destination, player)
    piece_in_hand  = actions.find_piece(origin, gamepieces)
    target_piece   = actions.find_piece(destination, gamepieces)
    target_empty   = target_piece.nil?

    if piece_in_hand.valid_move?(origin, destination, all_pieces) && 
       player.color == piece_in_hand.data[:color] &&
       (target_empty || player.color != target_piece.data[:color])
      
      actions.delete_piece(destination, gamepieces)
      actions.move_piece(origin, destination, all_pieces)
      actions.increase_move_count(piece_in_hand, player)

    else
      error_loop(player)
    end
    finalize_move(origin, destination, player, piece_in_hand, target_piece)
  end

  def finalize_move(origin, destination, player, piece_in_hand, target_piece)
    if player_in_check?(player)
      actions.move_piece(destination, origin, all_pieces)
      actions.decrease_move_count(piece_in_hand, player)
      @gamepieces.all_symbols << target_piece unless target_piece.nil?
      reset_current_message
      error_loop(player)
    else
      @current_msg = messages.capture(target_piece, player) unless target_piece.nil?
    end
  end

  def player_in_mate?(player)
    opponent_pieces = get_pieces_for(player, opponent=true)
    user_pieces     = get_pieces_for(player)
    
    advantage.checkmate?(user_pieces, opponent_pieces, all_pieces)
  end

  def player_in_check?(player)
    status          = false
    opponent_pieces = get_pieces_for(player, opponent=true)
    user_pieces     = get_pieces_for(player, opponent=false)
    user_king       = advantage.find_king(user_pieces)

    if advantage.check?(opponent_pieces, user_king, all_pieces)
      threat = opponent_pieces.select{ |i| i.data[:check] == true }
      threat = threat[0]
      status = true

      @current_msg += messages.check(threat)
    end
    status
  end

  def protect_king(origin, destination, player)
    opponent_pieces = get_pieces_for(player, opponent=true)
    piece_in_hand   = all_pieces.select { |piece| piece[:coordinates] == origin}
    (advantage.kings_unsafe_moves.include?(destination) && piece_in_hand[0][:name] == "king")
  end

  def display_message(player)
    puts @current_msg
    puts messages.turn(player)
    reset_current_message
  end

  def reset_current_message
    @current_msg = ""
  end

  def scan_answer(answer)
    #answer.scan(/^([a-h][1-8]\s[a-h][1-8])$/)
    answer.scan(/^([a-h][1-8]\s[a-h][1-8])(\scastle)?(\sen passant)?(\spromote)?/)
  end

  def invalid_input?(parsed_ans, player)
    if parsed_ans.empty?
      @current_msg = messages.invalid_input
      error_loop(player)
    end
  end

  def all_pieces
    @gamepieces.all_symbols.map{ |i| i.data }
  end

  def black_pieces
    @gamepieces.all_symbols.select{ |i| i.data[:color] == "black" }
  end

  def white_pieces
    @gamepieces.all_symbols.select{ |i| i.data[:color] == "white" }
  end

  def get_pieces_for(player, opponent=false)
    if (player.color == "white" && !opponent) || (player.color == "black" && opponent) 
      white_pieces
    elsif (player.color == "black" && !opponent) || (player.color == "white" && opponent)
      black_pieces
    end
  end

  def switch_players(player)
    player = player == @player1 ? @player2 : @player1
    play_game(player)
  end

  def game_loop(origin, destination, player)
    if actions.empty_spot?(origin, all_pieces)
      @current_msg = messages.empty_origin
      error_loop(player)
    elsif protect_king(origin, destination, player)
      @current_msg = messages.protect_king(player)
      error_loop(player)
    else
      make_move(origin, destination, player)
      reset_advantage_arrays
      switch_players(player)
    end
  end

  def reset_advantage_arrays
    advantage.kings_unsafe_moves = []
    advantage.potential_threats  = []
    advantage.current_threats    = []
    advantage.threat_attackers   = []
    advantage.threat_blockers    = []
  end

  def error_loop(player)
    reset_advantage_arrays
    @current_msg += messages.error
    play_game(player)
  end

  def end_game
    puts messages.game_over
    exit
  end

  def display_board
    system "clear" or system "cls"
    @game.fill_cells
    @gamepieces.all_symbols.each { |piece| @game.set_piece_coordinates(piece.data) }
    @instructions.display
    @game.print_board
    @game.reverse_board
  end
end

Play.new