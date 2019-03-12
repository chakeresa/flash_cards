class Turn
  attr_reader :card, :guess
  require './lib/card'
  require 'pry'
  def initialize(guess, card)
    @guess = guess
    @card = card
  end

  def correct?
    @guess.downcase == @card.answer.downcase
  end

  def feedback
    if correct?
      "Correct!"
    else
      "Incorrect."
    end
  end


end
