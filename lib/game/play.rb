require_relative 'player'
require_relative 'board'
require_relative 'game_pieces'
require_relative 'instructions'
require_relative 'messages'
require_relative 'advantage'          # check, checkmate, stalemate

require './lib/pieces/basic_actions'
require './lib/pieces/special_moves'

class Play
  attr_reader :actions, :advantage, :messages, :gamepieces, :current_msg

  def initialize
    @game         = Board.new
  
    @gamepieces   = GamePieces.new
    @player1      = Player.new("white")
    @player2      = Player.new("black")
    
    @actions      = BasicActions.new
    @advantage    = Advantage.new
    
    @instructions = Instructions.new
    @messages     = Messages.new
    @current_msg  = messages.blank

    play_game(@player1)
  end

  def play_game(player)
    display_board
    player_in_mate?(player)
    player_in_check?(player)

    display_message(player)

    answer      = player.take_turn
    parsed_ans  = scan_answer(answer)
    
    if parsed_ans.empty?
      error_loop(player)
    else
      user_input  = parsed_ans[0][0].split("")
      origin      = { x: user_input[0].ord  - 96, y: user_input[1].to_i }
      destination = { x: user_input[-2].ord - 96, y: user_input[-1].to_i }

      error_loop(player) if check_empty_origin(origin, player, all_pieces)
      make_move(origin, destination, player)
      
      switch_players(player)
    end
  end

  def make_move(origin, destination, player)
    piece_in_hand = actions.find_piece(origin, gamepieces)
    
    if piece_in_hand.valid_move?(origin, destination, all_pieces) && 
       player.color == piece_in_hand.data[:color]
      
      if actions.empty_spot?(destination, all_pieces)
        actions.move_piece(origin, destination, all_pieces)
        actions.increase_move_count(piece_in_hand, player)

        king_protection(origin, destination, piece_in_hand, player)
      elsif actions.friendly_fire?(origin, destination, all_pieces)
        @current_msg = messages.friendly_fire
        error_loop(player)
      elsif actions.capture_piece?(origin, destination, all_pieces)
        captured_piece = actions.find_piece(destination, gamepieces)
        
        actions.delete_piece(destination, gamepieces)
        actions.move_piece(origin, destination, all_pieces)
        actions.increase_move_count(piece_in_hand, player)

        king_protection(origin, destination, piece_in_hand, player, captured_piece)

        @current_msg = messages.capture(captured_piece, player)
      end
    
    else
      error_loop(player)
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
    user_king       = actions.find_king(player, all_pieces)

    if advantage.check?(opponent_pieces, user_king, all_pieces)
      threat = opponent_pieces.select{ |i| i.data[:check] == true }
      threat = threat[0]
      status = true

      @current_msg += messages.check(threat)
    end

    status
  end

  def king_protection(origin, destination, piece_in_hand, player, captured_piece=nil)
    opponent_pieces = get_pieces_for(player, opponent=true)
    user_king       = actions.find_king(player, all_pieces)

    if advantage.check?(opponent_pieces, user_king, all_pieces)
      @current_msg = messages.protect_king(player)
      
      actions.move_piece(destination, origin, all_pieces)
      actions.decrease_move_count(piece_in_hand, player)

      gamepieces.all_symbols << captured_piece unless captured_piece.nil?
      error_loop(player)
    end
  end

  def error_loop(player)
    @current_msg += messages.error
    play_game(player)
  end

  def scan_answer(answer)
    answer.scan(/^([a-h][1-8]\s[a-h][1-8])$/)
  end

  def check_empty_origin(origin, player, all_pieces)
    @current_msg = messages.empty_origin if actions.empty_spot?(origin, all_pieces)
  end

  def display_message(player)
    puts @current_msg
    puts messages.turn(player)
    @current_msg = ""
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