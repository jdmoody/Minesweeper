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
    end

    # def neighbors(tile)
    #   tile_row, tile_col = tile.location
    #   neighbor_shift = [[ 1, 0], [ 1,  1], [0,  1], [-1,  1],
    #                     [-1, 0], [-1, -1], [0, -1], [ 1, -1]]
    #   neighbor_arr = neighbor_shift.map do |move|
    #     move[0] + tile_row, move[1] + tile_col
    #   end
    # end

    def neighbor_bomb_count

    end

  end
end