module Minesweeper

  class Tile
    attr_reader :unexplored, :has_bomb, :flagged

    def initialize(location, has_bomb = false)
      @location = location
      @has_bomb = has_bomb
      @unexplored = true
      @flagged = false
    end


  end

  class Board
    def initialize(board_size = [9, 9])
      @board_size = board_size
      @num_rows = @board_size[0]
      @num_cols = @board_size[1]
      @num_bombs = 10
    end

    def build_empty_board
      @board = Array.new(@num_rows) { Array.new }
      @num_rows.times do |row|
        @num_cols.times do |col|
          @board[row] << Tile.new([row, col])
        end
      end
    end

    def show_board
      printed_board = @board.dup
      @num_rows.times do |row|
        @num_cols.times do |col|
          tile = printed_board[row][col]
          if tile.unexplored
            printed_board[row][col] = tile.flagged ? "F" : "*"
          end
        end
      end

      printed_board.each { |row| p row }
    end
  end
end


new_game = Minesweeper::Board.new
new_game.build_empty_board
new_game.show_board