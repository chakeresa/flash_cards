require './lib/card'
require './lib/deck'

class CardGenerator
  attr_reader :cards

  def initialize(filename)
    @cards = []
    @file = open(filename)
    read_each_line

  end

  private
    def read_each_line
      # to load other file types (other than CSV), change this interface -- too specific

      @file.each_line.with_index do |line, index|
        line_elements_as_array = line.chomp.split(",")

        # ignore lines without 3 inputs (question,answer,category)
        if line_elements_as_array.length == 3
          @cards << Card.new(line_elements_as_array[0], line_elements_as_array[1], line_elements_as_array[2])
        else
          p "Line #{index + 1} of your imported cards file has an invalid number of inputs (should have 3 -- question,answer,category)"
        end

      end

    end

end
