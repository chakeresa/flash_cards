require 'yaml'

class YmlParser
  attr_reader :data

  def initialize(filename)
    @file = YAML.load(File.open(filename))
    process_file
  end

  private
    def process_file

      @data = @file

        # bonus: add check to make sure only arrays with 3 elements [question, answer, category] are loaded

    end

end
