require './lib/card'
require './lib/deck'
require './lib/txt_parser'
require './lib/yml_parser'

class CardGenerator
  attr_reader :cards

  def initialize(parser)
    @cards = []
    @data = parser.data
    create_cards
  end

  def create_cards
    @data.each.with_index do |card, index|
      @cards << Card.new(@data[index][0], @data[index][1], @data[index][2])
    end
  end

end
