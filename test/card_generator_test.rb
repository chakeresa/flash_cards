require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/round'
require './lib/card_generator'
require 'pry'

class CardGeneratorTest < Minitest::Test

  def test_it_makes_an_array_of_cards
    filename = "cards.txt"
    card_generator = CardGenerator.new(filename)
    cards = card_generator.cards
    assert_instance_of Array, cards
    assert_instance_of Card, cards[0]
  end

  def test_the_cards_imported
    filename = "cards.txt"
    card_generator = CardGenerator.new(filename)
    cards = card_generator.cards

    assert_equal "10", cards[0].answer
    assert_equal "STEM", cards[0].category

    assert_equal "red panda", cards[1].answer
    assert_equal "Turing Staff", cards[1].category
  end
end