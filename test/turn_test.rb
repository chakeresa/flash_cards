require 'minitest/autorun'
require 'minitest/pride'
require './lib/turn'
require './lib/card'

class TurnTest < Minitest::Test
  def test_turn_exists
    card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    turn = Turn.new("Juneau", card)

    assert_instance_of Turn, turn
  end

  def test_turn_has_a_guess
    card = Card.new("What is the abbreviation for iron?", "Fe", :STEM)
    turn = Turn.new("Ir", card)

    assert_equal "Ir", turn.guess
  end

  def test_turn_has_a_card
    card = Card.new("What is the abbreviation for iron?", "Fe", :STEM)
    turn = Turn.new("Ir", card)

    assert_equal card, turn.card
    assert_instance_of Card, turn.card
  end

  def test_it_needs_a_card_object
    card = 42
    turn = Turn.new("Ir", card)

    assert_nil turn.card
  end

  def test_right_answer_is_correct
    card = Card.new("What is the abbreviation for iron?", "Fe", :STEM)
    turn = Turn.new("Fe", card)

    assert turn.correct?
  end

  def test_right_answer_is_not_case_sensitive
    card = Card.new("What is the abbreviation for iron?", "Fe", :STEM)
    turn = Turn.new("FE", card)

    assert turn.correct?
  end

  def test_wrong_answer_is_not_correct
    card = Card.new("What is the abbreviation for iron?", "Fe", :STEM)
    turn = Turn.new("Ir", card)

    refute turn.correct?
  end

  def test_feedback_returns_correct_when_right
    card = Card.new("What is the abbreviation for iron?", "Fe", :STEM)
    turn = Turn.new("Fe", card)

    assert_equal "Correct!", turn.feedback
  end

  def test_feedback_returns_incorrect_when_wrong
    card = Card.new("What is the abbreviation for iron?", "Fe", :STEM)
    turn = Turn.new("Ir", card)

    assert_equal "Incorrect.", turn.feedback
  end

end
