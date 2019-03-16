require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/round'


class RoundTest < Minitest::Test
  def setup
    card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    card_4 = Card.new("What is the abbreviation for the element iron?", "Fe", :STEM)

    deck = Deck.new([card_1, card_2, card_3, card_4])

    @round = Round.new(deck)
  end

  def test_it_exists
    round = @round

    assert_instance_of Round, round
  end

  def test_it_has_a_deck
    round = @round

    assert_instance_of Deck, round.deck
  end

  def test_input_must_be_a_deck
    round = Round.new(25)

    assert_nil round.deck
  end

  def test_it_has_turn_with_a_current_card
    round = @round

    assert_equal [], round.turns
    assert_instance_of Card, round.current_card
  end

  def test_it_takes_a_turn
    round = @round

    turn_1 = round.take_turn("Juneau") # right answer

    assert_instance_of Turn, turn_1
    assert turn_1.correct?
    assert_equal "Correct!", round.turns.last.feedback
    assert_instance_of Turn, round.turns[0]
    assert_equal 1, round.turns.count
  end

  def test_it_takes_another_turn
    round = @round

    turn_1 = round.take_turn("Juneau") # right answer
    turn_2 = round.take_turn("Venus") # wrong answer

    assert_instance_of Turn, turn_2
    refute turn_2.correct?
    assert_equal "Incorrect.", round.turns.last.feedback
    assert_equal 2, round.turns.count
    assert_equal "North north west", round.current_card.answer
  end

  def test_it_takes_a_turn_and_advances_to_next_card
    round = @round

    new_turn = round.take_turn("Anchorage")

    assert_equal "Mars", round.current_card.answer
  end

  def test_number_correct_is_initially_0
    round = @round

    assert_equal 0, round.number_correct
  end

  def test_number_correct_not_changed_by_wrong_answer
    round = @round

    new_turn = round.take_turn("Anchorage") # wrong answer

    assert_equal 0, round.number_correct
  end

  def test_number_correct_increases_after_right_answer
    round = @round

    new_turn = round.take_turn("Juneau") # right answer

    assert_equal 1, round.number_correct
  end

  def test_it_calculates_number_correct_for_2_right_answers
    round = @round

    new_turn = round.take_turn("Juneau") # right answer
    new_turn = round.take_turn("Mars") # right answer

    assert_equal 2, round.number_correct
  end

  def test_it_calculates_percent_correct_for_only_right_answers
    round = @round

    new_turn = round.take_turn("Juneau") # right answer
    new_turn = round.take_turn("Mars") # right answer

    assert_in_delta 100.0, round.percent_correct, 0.1
  end

  def test_it_calculates_percent_correct_for_half_right_answers
    round = @round

    new_turn = round.take_turn("Juneau") # right answer
    new_turn = round.take_turn("Venus") # wrong answer

    assert_in_delta 50.0, round.percent_correct, 0.1
  end

  def test_it_calculates_percent_correct_for_no_right_answers
    round = @round

    new_turn = round.take_turn("Anchorage") # wrong answer
    new_turn = round.take_turn("Venus") # wrong answer

    assert_in_delta 0.0, round.percent_correct, 0.1
  end

  def test_it_calculates_number_correct_for_a_category
    round = @round

    round.take_turn("Juneau") # correct answer in :Geography category
    round.take_turn("Mars") # correct answer in :STEM category
    round.take_turn("West") # incorrect answer in :STEM category
    round.take_turn("Fe") # correct answer in :STEM category

    assert_equal 1, round.number_correct_by_category(:Geography)
    assert_equal 2, round.number_correct_by_category(:STEM)
  end

  def test_it_returns_zero_correct_for_nonexistant_category
    round = @round

    round.take_turn("Juneau") # correct answer in :Geography category
    round.take_turn("Mars") # correct answer in :STEM category
    round.take_turn("West") # incorrect answer in :STEM category
    round.take_turn("Fe") # correct answer in :STEM category

    assert_equal 0, round.number_correct_by_category(:PopCulture)
  end

  def test_it_calculates_percent_correct_for_a_category
    round = @round

    round.take_turn("Juneau") # correct answer in :Geography category
    round.take_turn("Mars") # correct answer in :STEM category
    round.take_turn("West") # incorrect answer in :STEM category
    round.take_turn("Fe") # correct answer in :STEM category

    assert_in_delta 75.0, round.percent_correct, 0.1
    assert_in_delta 66.7, round.percent_correct_by_category(:STEM), 0.1
    assert_instance_of Hash, round.all_categories_and_percentages
    assert_in_delta 66.7, round.all_categories_and_percentages[:STEM], 0.1
  end

  def test_start_messages
    round = @round

    assert_includes round.start_messages, "Welcome! You're playing with 4 cards."
    assert_includes round.start_messages, "---"
  end

  def test_prompt_messages_first_question
    round = @round

    assert_includes round.prompt_messages, "This is card number 1 out of 4."
    assert_includes round.prompt_messages, "Question: What is the capital of Alaska?"
    assert_includes round.prompt_messages, "Enter your guess:"
  end

  def test_prompt_messages_second_question
    round = @round

    round.take_turn("Juneau")

    assert_includes round.prompt_messages, "The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?"
  end

  def test_end_messages
    round = @round

    round.take_turn("Juneau") # right answer in Geography category
    round.take_turn("Mars") # right answer in STEM category
    round.take_turn("East") # wrong answer in STEM category
    round.take_turn("Ir") # wrong answer in STEM category

    assert_includes round.end_messages, "***"
    assert_includes round.end_messages, "Game over!"
    assert_includes round.end_messages, "You had 2 correct guesses out of 4 for a total score of 50.0%."
    assert_includes round.end_messages, "Geography - 100.0% correct"
    assert_includes round.end_messages, "STEM - 33.3% correct"
  end

end
