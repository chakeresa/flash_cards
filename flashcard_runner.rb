require './lib/card'
require './lib/deck'
require './lib/turn'
require './lib/round'
require './lib/card_generator'
require './lib/txt_parser'
require './lib/yml_parser'

####### replaced this part with the file import below #######
# # Create some Cards
# card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
# card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
# card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
# card_4 = Card.new("What is the abbreviation for the element iron?", "Fe", :STEM)
#
# # Put those card into a Deck
# deck = Deck.new([card_1, card_2, card_3, card_4])

####### txt option
# filename = "cards.txt"
# data = TxtParser.new(filename)

####### yml option
filename = "cards.yml"
data = YmlParser.new(filename)

deck_prep = CardGenerator.new(data).cards
deck = Deck.new(deck_prep)

# Create a new Round using the Deck you created
round = Round.new(deck)

# Start the round using a new method called start (round.start)
round.start
