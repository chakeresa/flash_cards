require './lib/turn'
require './lib/card'
require './lib/deck'

class Round
  attr_reader :deck, :turns, :number_correct

  def initialize(deck)
    @deck = deck
    @turns = []
    @number_correct = 0
    @current_question = 0
  end

  def current_card
    @deck.cards[@current_question]
  end

  def take_turn(guess)
    new_turn = Turn.new(guess, current_card)

    if new_turn.correct?
      @number_correct += 1
    end

    @current_question += 1
    @turns << new_turn

    new_turn
  end

  def start # ****try to abstract out the messages from here****
    puts "Welcome! You're playing with #{@deck.count} cards."
    puts "-------------------------------------------------"

    while @turns.count < @deck.count
      puts "This is card number #{@turns.count + 1} out of #{@deck.count}."
      puts "Question: #{current_card.question}"

      print "Enter your guess: > "
      guess = gets.chomp
      take_turn(guess)

      puts @turns.last.feedback
    end

    puts "****** Game over! ******"
    puts "You had #{@number_correct} correct guesses out of #{@deck.count} for a total score of #{percent_correct}%."

    all_categories_and_percentages.each do |category, percent|
      puts "#{category} - #{percent}% correct"
    end

  end

  def number_correct_by_category(category)
    correct_in_category = 0

    turns_in_category(category).each do |turn|
      if turn.correct?
        correct_in_category += 1
      end
    end

    correct_in_category
  end

  def percent_correct
    (@number_correct.to_f) / (@turns.count) * 100
  end

  def turns_in_category(category)
    @turns.select{|turn| turn.card.category == category}
  end

  def percent_correct_by_category(category)
    total_number_in_category = turns_in_category(category).count
    percent = (number_correct_by_category(category).to_f) / (total_number_in_category.to_f) * 100
    percent.round(1)
  end

  def all_categories_and_percentages
    data = {}

    @turns.each do |turn|
      data[turn.card.category] = percent_correct_by_category(turn.card.category)
    end

    data
  end

end
