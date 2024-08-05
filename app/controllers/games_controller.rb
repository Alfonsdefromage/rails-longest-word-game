class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  VOWELS = %w[A E I O U]

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle
    # @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word(@word)
  end
  # def score
  #   @letters = params[:letters].split
  #   @word = params[:word].downcase
  #   url = "https://dictionary.lewagon.com/#{@word}"
  #   # Open the URL and read the data
  #   data = URI.open(url).read
  #   # Parse the JSON data
  #   @parsed_data = JSON.parse(data)
  #   word_letters = @word.chars

  #   compared = @letters.all? { |letter| word_letters.include?(letter) }
  #   raise
  #   if @parsed_data["error"] == "word not found"
  #     @result = "Sorry but #{@word.upcase} does not seem to be a valid English word.."
  #   elsif @parsed_data["found"] == true && compared == false
  #     @result = "Sorry but #{@word.upcase} can't be build with #{@letters.join(",")}"
  #   else
  #     @result = "<strong>Congratulations!</strong> #{word.upcase} is a valid English word."
  # #   end
  # end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word(word)
    @letters = params[:letters].split
    @word = params[:word].downcase
    url = "https://dictionary.lewagon.com/#{@word}"
    # Open the URL and read the data
    data = URI.open(url).read
    # Parse the JSON data
    @parsed_data = JSON.parse(data)
    @parsed_data['found']
  end
end
