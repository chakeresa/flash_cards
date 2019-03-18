require 'minitest/autorun'
require 'minitest/pride'
require './lib/round'
require './lib/card_generator'
require './lib/txt_parser'

class TxtParserTest < Minitest::Test
  def test_it_exists
    filename = "cards.txt"
    parser = TxtParser.new(filename)
    data = parser.data

    assert_instance_of TxtParser, parser
    assert_instance_of Array, data
  end
end
