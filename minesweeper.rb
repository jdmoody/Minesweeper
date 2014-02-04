require './tile.rb'
require './board.rb'
require './hall_of_fame.rb'
require 'yaml'
require 'json'


module Minesweeper

  class GamePlay
    attr_accessor :board

    def initialize(board)
      @board = board
      @saved_time = 0
      @high_score = HOF.new
    end

    def play
      choose_game

      @start_time = Time.new
      until game_over?
        @board.show_board
        user_action
      end
      @high_score.show_high_scores
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
      @saved_time = (Time.new - @start_time).to_i
      puts "You've played for #{@saved_time} seconds so far"
      puts "Write the name of your savefile"
      savefile = gets.chomp
      File.open(savefile, "w") do |f|
        f.puts self.to_yaml
      end
      puts "Game saved as #{savefile}!"
      exit
    end

    def game_over?
      if @board.won?
        @board.show_board(true)
        puts "YOU DID IT!"
        score = (Time.new - @start_time).to_i + @saved_time
        puts "Your time was #{score} seconds!"
        @high_score.check_if_high_score(score)
        return true
      elsif @board.lost?
        puts "YOU LOSE"
        @board.show_board(true)
        return true
      else
        false
      end
    end
  end
end


board = Minesweeper::Board.new
new_game = Minesweeper::GamePlay.new(board)
new_game.play