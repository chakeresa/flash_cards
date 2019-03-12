require './lib/card'
require './lib/deck'
require './lib/turn'
require './lib/round'

# Create some Cards
card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
card_4 = Card.new("What is the abbreviation for the element iron?", "Fe", :STEM)

# Put those card into a Deck
deck = Deck.new([card_1, card_2, card_3, card_4])

# Create a new Round using the Deck you created
round = Round.new(deck)

# Start the round using a new method called start (round.start)
round.start
