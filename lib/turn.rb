require './lib/card'

class Turn
  attr_reader :card, :guess

  def initialize(guess, card)
    @guess = guess

    if card.class == Card # only allows Card inputs
      @card = card
    else
      p "Fix input -- second argument of Turn.new should be of Card class"
    end
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
