require './tile.rb'

module Minesweeper

  class Board
    attr_accessor :board, :num_rows, :num_cols
    def initialize(board_size = [9, 9])
      @board_size = board_size
      @num_rows = @board_size[0]
      @num_cols = @board_size[1]
      @num_bombs = 1
      build_empty_board
      place_bombs
    end

    def build_empty_board
      @board = Array.new(@num_rows) { Array.new }
      @num_rows.times do |row|
        @num_cols.times do |col|
          @board[row] << Tile.new(self, [row, col])
        end
      end
    end

    def place_bombs
      bombs_placed = 0
      until bombs_placed == @num_bombs
        b_row, b_col = rand(@num_rows), rand(@num_cols)
        tile = @board[b_row][b_col]
        unless tile.has_bomb
          @board[b_row][b_col].has_bomb = true
          bombs_placed += 1
        end
      end
    end

    def show_bombs
      @board.each do |row|
        row.each do |tile|
          tile.ui_graphic = "B" if tile.has_bomb
        end
      end
    end

    def show_board(game_over = false)
      show_bombs if game_over
      board.each do |row|
        puts row.map(&:ui_graphic).join(" ")
      end
    end

    def won?
      board.all? do |rows|
        rows.all? do |tile|
          (tile.has_bomb && tile.unexplored) ||
            (!tile.has_bomb && !tile.unexplored)
        end
      end
    end

    def lost?
      board.any? do |rows|
        rows.any? do |tile|
          !tile.unexplored && tile.has_bomb
        end
      end
    end
  end
end