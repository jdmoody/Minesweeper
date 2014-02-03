require './tile.rb'
require './board.rb'


module Minesweeper

  class GamePlay
    attr_accessor

    def initialize(board)
      @minesweeper = board
    end

    def show_board
      printed_board = []
      @minesweeper.board.each do |row|
        printed_board << row.dup
      end
      @minesweeper.num_rows.times do |row|
        @minesweeper.num_cols.times do |col|
          tile = printed_board[row][col]
          printed_board[row][col] = tile.ui_graphic
        end
      end
      printed_board.each { |row| p row }
    end

  end
end


board = Minesweeper::Board.new
new_game = Minesweeper::GamePlay.new(board)
board.build_empty_board
board.place_bombs
# board.board[1][1].change_flag_state
board.board[0][0].reveal
new_game.show_board