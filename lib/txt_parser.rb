class TxtParser
  attr_reader :data

  def initialize(filename)
    @file = open(filename)
    read_each_line
  end

  private
    def read_each_line

      @data = []

      @file.each_line.with_index do |line, index|
        line_elements_as_array = line.chomp.split(",")

        # ignore lines without 3 inputs (question,answer,category)
        if line_elements_as_array.length == 3
          @data << line_elements_as_array
        else
          p "Line #{index + 1} of your imported cards file has an invalid number of inputs (should have 3 -- question,answer,category)"
        end

      end

    end

end
