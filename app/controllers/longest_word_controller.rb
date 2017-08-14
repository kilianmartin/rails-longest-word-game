require 'open-uri'
require 'json'

class LongestWordController < ApplicationController
  def game

    alphabet = ("a".."z").to_a
    @grid = 9.times.map{alphabet.sample}.join(" ")
    @start_time = Time.now



  end




  def score
    @attempt = params[:attempt]
    @grid = params[:grid]
    @start_time = params[:start_time]
    @end_time = Time.now


    # word exists? (T/F)
    word_exists = JSON.parse(open("https://wagon-dictionary.herokuapp.com/" + @attempt.downcase).read)["found"]
    # word included? (T/F)

    word_included = @attempt.split("").all? { |letter| @grid.include?(letter)}
    # time it took
    duration_guess = @end_time.to_time - @start_time.to_time


    if word_exists == true && word_included == true
       score_guess = (@attempt.length * 3) / duration_guess.to_i
      message_guess = "Your word yielded #{score_guess} points."
    elsif word_exists == false
      score_guess = 0
      message_guess = "Word doesn't exist"
    elsif word_included == false
      score_guess = 0
      message_guess = "Word not in @grid"
    else
      return "error"
    end

  @result_hash = {
    time: duration_guess,
    score: score_guess,
    message: message_guess

  }

  end


end




