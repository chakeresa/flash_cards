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

      @data = @data.find_all do |entry|
        # only keep entries with three values (question, answer, category)
        entry.length == 3
      end

    end

end
