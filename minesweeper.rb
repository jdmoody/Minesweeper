module Minesweeper

  class Tile
    attr_accessor :unexplored, :has_bomb, :flagged, :location

    def initialize(location, has_bomb = false)
      @location = location
      @has_bomb = has_bomb
      @unexplored = true
      @flagged = false
    end

    def reveal

    end

    def neighbors

    end

  end

  class Board
    attr_accessor :board
    def initialize(board_size = [9, 9])
      @board_size = board_size
      @num_rows = @board_size[0]
      @num_cols = @board_size[1]
      @num_bombs = 10
      build_empty_board
      place_bombs
    end

    def build_empty_board
      @board = Array.new(@num_rows) { Array.new }
      @num_rows.times do |row|
        @num_cols.times do |col|
          @board[row] << Tile.new([row, col])
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

    def show_board
      printed_board = []
      @board.each do |row|
        printed_board << row.dup
      end
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
new_game.show_board