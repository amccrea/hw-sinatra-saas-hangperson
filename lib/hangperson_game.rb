class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  #rand_word = HangPersonGame.get_random_word 


  def initialize(word)# = rand_word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  attr_accessor :word, :guesses, :wrong_guesses
  
  # processes a guess and modifies the instance variables wrong_guesses and guesses accordingly
  def guess(letter)

    raise ArgumentError, 'Guess is nil' unless not letter.nil?
    raise ArgumentError, 'Guess is empty' unless not letter.empty?
    letter.downcase!
    raise ArgumentError, 'Guess is not a letter' unless letter.match(/^[[:alpha:]]$/) 

    if @word.include? letter
      if @guesses.include? letter
        return false
      else 
        @guesses += letter
      end
    else
      if @wrong_guesses.include? letter
        return false
      else
        @wrong_guesses += letter
      end
    end
  end

  #returns one of the symbols :win, :lose, or :play depending on the current game state
  def check_win_or_lose
     if word_with_guesses == @word
        return :win
     elsif @wrong_guesses.length >= 7
       return :lose  
     else
       return :play
     end
  end

  #substitutes the correct guesses made so far into the word.
  def word_with_guesses
     return @word.gsub(/[^#{@guesses}]/,'-') 
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
