require_relative 'player'
require_relative 'board'
require_relative 'game_pieces'
require_relative 'instructions'
require_relative 'messages'
require_relative 'advantage'          # check, checkmate, stalemate

require './lib/pieces/basic_actions'
require './lib/pieces/special_moves'

class Play
  attr_reader :actions, :advantage, :messages, :pieces

  def initialize
    @game         = Board.new
  
    @pieces       = GamePieces.new
    @player1      = Player.new("white")
    @player2      = Player.new("black")
    
    @actions      = BasicActions.new
    @advantage    = Advantage.new
    
    @instructions = Instructions.new
    @messages     = Messages.new

    play_game(@player1)
  end

  def play_game(player)
    display_board
    messages.turn(player)

    answer      = player.take_turn
    parsed_ans  = scan_answer(answer)
    
    if parsed_ans.empty?
      error_loop(player)
    else
      user_input  = parsed_ans[0][0].split('')
      origin      = { x: user_input[0].ord  - 96, y: user_input[1].to_i }
      destination = { x: user_input[-2].ord - 96, y: user_input[-1].to_i }

      make_move(origin, destination, player)
      switch_players(player)
    end
  end

  def make_move(origin, destination, player)
    piece                = actions.find_piece(origin, pieces)
    origin_is_empty      = actions.empty_spot?(origin, all_pieces)
    destination_is_empty = actions.empty_spot?(destination, all_pieces)

    error_loop(player) if origin_is_empty

    if piece.valid_move?(origin, destination, all_pieces) && 
       player.color == piece.data[:color]
      
      if destination_is_empty
        actions.move_piece(origin, destination, pieces)
        actions.increase_move_count(piece, player)
        
        opponent_in_check?(player)
        king_protection(origin, destination, piece, player)
  
      elsif actions.friendly_fire?(origin, destination, all_pieces)
        messages.friendly_fire(player)
        error_loop(player)

      elsif actions.capture_piece?(origin, destination, all_pieces)
        captured_piece = actions.find_piece(destination, pieces)
        actions.delete_piece(destination, pieces)

        actions.move_piece(origin, destination, pieces)
        actions.increase_move_count(piece, player)

        king_protection(origin, destination, piece, player, captured_piece)

        messages.capture(captured_piece)
        opponent_in_check?(player)
      end
    
    else
      error_loop(player)
    end
  end

  def opponent_in_check?(player)
    user_pieces   = user_pieces(player)
    opponent_king = opponent_king(player)

    if advantage.check?(user_pieces, opponent_king, all_pieces)
      messages.check(player)
    end
  end

  def king_protection(origin, destination, piece, player, captured_piece=nil)
    opponent_pieces    = opponent_pieces(player)
    user_king          = user_king(player)

    if advantage.check?(opponent_pieces, user_king, all_pieces)
      messages.protect_king(player)
      
      actions.move_piece(destination, origin, pieces)
      actions.decrease_move_count(piece, player)

      pieces.all_symbols << captured_piece unless captured_piece.nil?
      error_loop(player)
    end
  end

  def error_loop(player)
    messages.error(player)
    play_game(player)
  end

  def scan_answer(answer)
    answer.scan(/^([a-h][1-8]\s[a-h][1-8])$/)
  end

  def switch_players(player)
    player = player == @player1 ? @player2 : @player1
    play_game(player)
  end

  # ----- methods related to interface display ----- #
  def display_board
    pause
    clear_screen
    fill_board
    show_instructions
    print_board
    reverse_board
  end

  def pause
    sleep 1.5
  end

  def clear_screen
    system 'clear' or system 'cls'
  end

  def fill_board
    @game.fill_cells
    @pieces.all_symbols.each { |piece| @game.set_piece_coordinates(piece.data) }
  end

  def show_instructions
    @instructions.display
  end

  def print_board
    @game.print_board
  end

  def reverse_board
    @game.reverse_board
  end

  # ----- methods related to user pieces ----- #
  def all_pieces
    ans = @pieces.all_symbols.map{ |i| i.data }
  end

  def black_pieces
    @pieces.all_symbols.select{ |i| i.data[:color] == "black" }
  end

  def white_pieces
    @pieces.all_symbols.select{ |i| i.data[:color] == "white" }
  end

  def user_king(player)
    user_king          = actions.find_your_king(player, white_pieces, black_pieces)
    user_king_location = user_king[:coordinates]
  end

  def user_pieces(player)
    player.color == "white" ? white_pieces : black_pieces
  end

  def opponent_king(player)
    opponent_king          = actions.find_opponent_king(player, white_pieces, black_pieces)
    opponent_king_location = opponent_king[:coordinates]
  end

  def opponent_pieces(player)
    player.color == "black" ? white_pieces : black_pieces
  end
end

Play.new