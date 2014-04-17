class FlightSheet

  def initialize input_file, output_file
    self.input = CsvReader.new(input_file)
    self.output = CsvCreator.new(@input.header, output_file)
    self.parser = CsvParser.new(@input, @output)
  end

  def create
    @input.file.each do |row|
      next unless new_row = @parser.parse_row(row)
      @output.file <<  new_row
    end
    @parser.close
  end

  private
  attr_accessor :input, :output, :parser

end
