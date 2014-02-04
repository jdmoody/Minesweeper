require './tile.rb'
require './board.rb'
require 'yaml'


module Minesweeper

  class GamePlay
    attr_accessor :board

    def initialize(board)
      @board = board
    end

    def play
      choose_game

      until game_over?
        show_board
        user_action
      end
    end

    def choose_game
      puts "Would you like to load a game? (Otherwise, a new one will begin)"
      if gets.chomp == "yes"
        puts "What is the file name?"
        filename = gets.chomp
        saved_game = YAML::load(File.read(filename))
        self.board = saved_game.board
      end
    end

    def choose_flags
      puts "Choose a location to flag/unflag (row,col)"
      f_row, f_col = gets.chomp.split(",")
      @board.board[f_row.to_i][f_col.to_i].change_flag_state
    end

    def user_action
      puts "Choose a location to unveil (row,col)"
      puts "Type 'f' if you want to flag/unflag a square"
      puts "Type 's' if you want to save"
      p_row, p_col = gets.chomp.split(",")
      if p_row == "f"
        choose_flags
      elsif p_row == "s"
        save_game
      else
        @board.board[p_row.to_i][p_col.to_i].reveal
      end
    end

    def save_game
      puts "Write the name of your savefile"
      savefile = gets.chomp
      File.open(savefile, "w") do |f|
        f.puts self.to_yaml
      end
      puts "Game saved as #{savefile}!"
    end

    def show_board(game_over = false)
      @board.show_bombs if game_over
      @board.board.each do |row|
        puts row.map(&:ui_graphic).join(" ")
      end
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