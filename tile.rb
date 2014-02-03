require './board.rb'

module Minesweeper

  class Tile
    attr_accessor :unexplored, :has_bomb, :flagged, :location, :ui_graphic

    def initialize(board, location, has_bomb = false)
      @board = board
      @location = location
      @has_bomb = has_bomb
      @unexplored = true
      @flagged = false
      @row = location[0]
      @col = location[1]
      @ui_graphic = "*"
    end

    def reveal
      @unexplored = false
      bomb_count = neighbor_bomb_count
      if @has_bomb
        @ui_graphic = "B"
      elsif bomb_count > 0
        @ui_graphic = bomb_count.to_s
      else
        unrevealed = neighbors.select { |neighbor| neighbor.unexplored }
        unrevealed.each { |neighbor| neighbor.reveal }
        @ui_graphic = "_"
      end
    end

    def neighbors
      tile_row, tile_col = tile.location
      neighbor_shift = [[ 1, 0], [ 1,  1], [0,  1], [-1,  1],
                        [-1, 0], [-1, -1], [0, -1], [ 1, -1]]

      neighbor_arr = neighbor_shift.map do |move|
        potential_neighbor = move[0] + tile_row, move[1] + tile_col
        next if off_board?(potential_neighbor)
        potential_neighbor
      end

      neighbor_arr.map do |loc|
        row, col = loc
        @board.board[row][col]
      end
    end

    def neighbor_bomb_count
      bomb_count = 0
      neighbors.each do |neighbor|
        bomb_count += 1 if neighbor.has_bomb
      end
    end

    def off_board?(neighbor)
      (neighbor[0] < 0 || neighbor[0] > @board.num_rows) &&
        (neighbor[1] < 0 || neighbor[1] > @board.num_cols)
    end
  end
end