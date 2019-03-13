class CardGenerator
  attr_reader :cards
  require './lib/card'
  require './lib/deck'

  def initialize(filename)
    @cards = []
    file = open(filename)
    # helpful example https://code-maven.com/open-file-and-read-content-in-ruby
    file.each_line do |line|
      line_elements_as_array = line.chomp.split(",")
      @cards << Card.new(line_elements_as_array[0], line_elements_as_array[1], line_elements_as_array[2])
    end

  end

end
