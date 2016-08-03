require_relative 'player'
require_relative 'board'
require_relative 'instructions'
require_relative 'game_pieces'
require_relative 'advantage'          # check, checkmate, stalemate

require './lib/pieces/basic_actions'
require './lib/pieces/special_moves'

class Play
  attr_reader :actions, :advantage

  def initialize
    @game         = Board.new
    @pieces       = GamePieces.new
    @player1      = Player.new("white")
    @player2      = Player.new("black")
    @actions      = BasicActions.new
    @advantage    = Advantage.new
    @instructions = Instructions.new

    play_game(@player1)
  end

  def play_game(player)
    display_board
    turn_message(player)

    answer      = player.take_turn
    parsed_ans  = scan_answer(answer)
    user_input  = parsed_ans[0].split("")

    origin      = { x: user_input[0].ord  - 96, y: user_input[1].to_i }
    destination = { x: user_input[-2].ord - 96, y: user_input[-1].to_i }

    if parsed_ans.empty?
      error_message
      play_game(player)
    else
      make_move(origin, destination, player)
      switch_players(player)
    end
  end

  def check_advantage(player)
    advantage.check?(player, white_pieces, black_pieces, all_pieces)
  end

  def make_move(origin, destination, player)
    piece                = find_piece_at(origin)
    origin_is_empty      = actions.empty_spot?(origin, all_pieces)
    destination_is_empty = actions.empty_spot?(destination, all_pieces)

    error_message(player) if origin_is_empty

    if piece.valid_move?(origin, destination, all_pieces) && 
       player.color == piece.data[:color]
      
      if destination_is_empty
        move_piece(origin, destination)
        increase_move_count(piece, player)
        
        check_advantage(player)

      elsif actions.friendly_fire?(origin, destination, all_pieces)
        friendly_fire_message(player)

      elsif actions.capture_piece?(origin, destination, all_pieces)
        captured_piece = find_piece_at(destination)
        capture_message(captured_piece)
        delete_piece_at(destination)
        
        move_piece(origin, destination)
        increase_move_count(piece, player)

        check_advantage(player)
      end
    
    else
      error_message(player)
    end



  end

  def display_board
    #pause
    #clear_screen
    fill_board
    show_instructions
    print_board
    reverse_board
  end

  def all_pieces
    ans = @pieces.all_symbols.map{ |i| i.data }
    ans
  end

  def black_pieces
    @pieces.all_symbols.select{ |i| i.data[:color] == "black" }
    #ans = ans.map{ |i| i.data }
  end

  def white_pieces
    @pieces.all_symbols.select{ |i| i.data[:color] == "white" }
    #ans = ans.map{ |i| i.data }
  end

  def pause
    sleep 0.5
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

  def error_message(player)
    puts "Don't ever play yourself."
    play_game(player)
    pause
  end

  def friendly_fire_message(player)
    puts "No Friendly Fire!"
    error_message(player)
  end

  def capture_message(captured_piece)
    puts "#{captured_piece.data[:color].capitalize}'s #{captured_piece.data[:name]} has been captured!"
  end

  def turn_message(player)
    puts "\n» #{player.color.capitalize}'s turn:"
  end

  def scan_answer(answer)
    answer.scan(/[a-h][1-8] to [a-h][1-8]|castle?|en passant?|promotion?/)
  end

  def switch_players(player)
    player = player == @player1 ? @player2 : @player1
    play_game(player)
  end

  def move_piece(origin, destination)
    target = @pieces.all_symbols.select { |piece| piece.data[:coordinates] == origin}
    target[0].data[:coordinates] = destination
  end

  def increase_move_count(piece, player)
    piece.data[:move_count] += 1
    player.total_moves += 1
  end

  def delete_piece_at(coord)
    @pieces.all_symbols.delete_if do |piece|
      piece.data[:coordinates] == coord
    end
  end

  def find_piece_at(origin)
    target = @pieces.all_symbols.select { |piece| piece.data[:coordinates] == origin}
    target[0]
  end
end

Play.new