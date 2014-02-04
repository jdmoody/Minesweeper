require 'json'

module Minesweeper
  class HOF
    def update_high_scores(score, hs_list)
      inits = gets.chomp.upcase
      hs_list << [inits[0..3], score]
      hs_list.sort! { |score_1, score_2| score_1[1] <=> score_2[1] }
      hs_list = hs_list[0...10]
      save_high_scores(hs_list)
    end

    def save_high_scores(hs_list)
      File.open("high_scores", "w") do |f|
        f.puts hs_list.to_json
      end
    end

    def check_if_high_score(score)
      hs_list = load_high_scores
      if hs_list.last[1] > score
        puts "YOU GOT A HIGH SCORE"
        puts "Please enter your initials (3 at most)"
        update_high_scores(score, hs_list)
      end
    end

    def load_high_scores
      high_scores_file = File.read("high_scores")
      hs_list = JSON.parse(high_scores_file)
    end

    def show_high_scores
      hs_list = load_high_scores
      puts "HIGH SCORES"
      hs_list.each { |score| puts "#{score[0]} : #{score[1]} seconds" }
    end
  end
end