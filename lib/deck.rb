class Deck
  attr_reader :cards

  def initialize(cards)
    @cards = cards.select {|element| element.class == Card} # only allows Card inputs, ignores the others
  end

  def count
    @cards.count
  end

  def cards_in_category(category)
    @cards.select {|card| card.category == category}
  end

end
