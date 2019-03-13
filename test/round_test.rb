require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/round'
require 'pry'

def setup_cards_deck_and_round
  card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
  card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
  card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
  card_4 = Card.new("What is the abbreviation for the element iron?", "Fe", :STEM)

  deck = Deck.new([card_1, card_2, card_3, card_4])

  round = Round.new(deck)
end

class RoundTest < Minitest::Test
  def test_round_has_a_deck
    round = setup_cards_deck_and_round

    assert_instance_of Deck, round.deck
  end

  def test_round_has_turn_with_a_current_card
    round = setup_cards_deck_and_round

    assert_equal [], round.turns
    assert_instance_of Card, round.current_card
  end

  def test_takes_a_turn
    round = setup_cards_deck_and_round

    new_turn = round.take_turn("Juneau") # correct answer

    assert_instance_of Turn, new_turn
    assert new_turn.correct?
    assert_equal "Correct!", round.turns.last.feedback
    assert_instance_of Turn, round.turns[0]
    assert_equal 1, round.number_correct
    assert_equal "Mars", round.current_card.answer
  end

  def test_takes_2_turns
    round = setup_cards_deck_and_round

    round.take_turn("Juneau") # correct answer in :Geography category
    round.take_turn("Venus") # incorrect answer in :STEM category

    assert_equal 2, round.turns.count # checks that there are 2 elements in the round's `turns` array
    assert_equal "Incorrect.", round.turns.last.feedback
    refute round.turns.last.correct?
    assert_equal 1, round.number_correct
    assert_equal 1, round.number_correct_by_category(:Geography)
    assert_equal 0, round.number_correct_by_category(:STEM)
    assert_in_delta 50.0, round.percent_correct, 0.1
    assert_in_delta 100.0, round.percent_correct_by_category(:Geography), 0.1
    assert_equal "North north west", round.current_card.answer
  end

  def test_takes_4_turns
    round = setup_cards_deck_and_round

    round.take_turn("Juneau") # correct answer in :Geography category
    round.take_turn("Mars") # correct answer in :STEM category
    round.take_turn("West") # incorrect answer in :STEM category
    round.take_turn("Fe") # correct answer in :STEM category

    assert_in_delta 75.0, round.percent_correct, 0.1
    assert_in_delta 66.7, round.percent_correct_by_category(:STEM), 0.1
    assert_instance_of Hash, round.all_categories_and_percentages
    assert_in_delta 66.7, round.all_categories_and_percentages[:STEM], 0.1
  end

end
