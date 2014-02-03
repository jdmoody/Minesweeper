require './tile.rb'
require './board.rb'


module Minesweeper

  class GamePlay
    attr_accessor

    def initialize(board)
      @board = board
    end

    def play
      until game_over?
        show_board
        puts "Do you want to flag/unflag any squares?"
        if gets.chomp == "yes"
          puts "Choose a location to flag/unflag (row, col)"
          f_row, f_col = gets.chomp.split(",")
          @board.board[f_row.to_i][f_col.to_i].change_flag_state
          show_board
        end
        puts "Choose a location to unveil (row,col)"
        p_row, p_col = gets.chomp.split(",")
        @board.board[p_row.to_i][p_col.to_i].reveal
      end
    end

    def show_board(game_over = false)
      printed_board = []
      @board.board.each do |row|
        printed_board << row.dup
      end
      @board.num_rows.times do |row|
        @board.num_cols.times do |col|
          tile = printed_board[row][col]
          printed_board[row][col] = tile.ui_graphic
          if game_over
            if tile.has_bomb
              printed_board[row][col] = "B"
            end
          end
        end
      end
      printed_board.each { |row| p row }
    end

    def game_over?
      if won?
        puts "YOU DID IT!"
        return true
      elsif lost?
        puts "YOU LOSE"
        show_board(true)
        return true
      else
        false
      end
    end

    def won?
      @board.board.all? do |rows|
        rows.all? do |tile|
          (tile.has_bomb && tile.unexplored) ||
            (!tile.has_bomb && !tile.unexplored)
        end
      end
    end

    def lost?
      @board.board.any? do |rows|
        rows.any? do |tile|
          !tile.unexplored && tile.has_bomb
        end
      end
    end
  end
end


board = Minesweeper::Board.new
new_game = Minesweeper::GamePlay.new(board)
new_game.play