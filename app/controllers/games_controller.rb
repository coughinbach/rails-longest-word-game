require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = []
    8.times { |i| @letters << ("A".."Z").to_a.sample }
    2.times { |i| @letters << (["A", "E", "I", "O", "U", "Y"]).sample }
    @letters.shuffle!
  end

  def score
    @guess = params[:guess]
    @letters = params[:letters].split
    @english_word = english?(@guess)
    @valid_word = valid?(@guess, @letters)
  end

  def valid?(guess, letters)
    fate = []
    @guess.upcase.split(//).each { |guess_letter| fate << letters.include?(guess_letter) }
    fate.all?
  end

  def english?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
