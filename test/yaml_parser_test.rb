require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/round'
require './lib/card_generator'
require './lib/yml_parser'

class YmlParserTest < Minitest::Test
  def test_it_exists
    filename = "cards.yml"
    parser = YmlParser.new(filename)
    data = parser.data

    assert_instance_of YmlParser, parser
    assert_instance_of Array, data
  end
end
