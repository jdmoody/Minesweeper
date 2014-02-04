require './board.rb'

module Minesweeper

  class Tile
    attr_accessor :unexplored, :has_bomb, :flagged, :location

    def initialize(board, location, has_bomb = false)
      @board = board
      @location = location
      @has_bomb = has_bomb
      @unexplored = true
      @flagged = false
      @row = location[0]
      @col = location[1]
    end

    def reveal
      if @flagged
        puts "This square is flagged"
        return
      elsif @has_bomb
        @unexplored = false
        puts "BOOM"
        return
      end

      @unexplored = false
      if neighbor_bomb_count == 0
        unrevealed = neighbors.select do |neighbor|
          neighbor.unexplored && !neighbor.flagged
        end
        unrevealed.each { |neighbor| neighbor.reveal }
      end
    end

    def neighbors
      tile_row, tile_col = @location
      neighbor_shift = [[ 1, 0], [ 1,  1], [0,  1], [-1,  1],
                        [-1, 0], [-1, -1], [0, -1], [ 1, -1]]

      neighbor_arr = neighbor_shift.map do |move|
        [move[0] + tile_row, move[1] + tile_col]
      end

      valid_neighbors(neighbor_arr).map do |loc|
        row, col = loc
        @board.board[row][col]
      end

    end

    def neighbor_bomb_count
      bomb_count = 0
      neighbors.each do |neighbor|
        bomb_count += 1 if neighbor.has_bomb
      end
      bomb_count
    end

    def valid_neighbors(neighbors)
      neighbors.select do |neighbor|
        (neighbor[0] >= 0 && neighbor[0] < @board.num_rows) &&
          (neighbor[1] >= 0 && neighbor[1] < @board.num_cols)
      end
    end

    def change_flag_state
      @flagged = !@flagged
    end

    def to_s
      if @unexplored
        @flagged ? "F" : "*"
      elsif @has_bomb
        "B"
      else
        neighbor_bomb_count == 0 ? "_" : neighbor_bomb_count.to_s
      end
    end
  end
end