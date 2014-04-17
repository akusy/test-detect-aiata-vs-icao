class CsvParser < CsvBase

  def initialize input, output
    self.input = input
    self.output = output
    self.field_index = input.mapper["carrier_code"]
    self.invalid_rows = []
  end

  def parse_row row
    return nil unless field = detect_flight(row)
    Array.new(row).insert(output.mapper["carrier_code_type"], field)
  end

  def close
    if @invalid_rows.any?
      self.error_csv = build_csv("error.csv", @input.header)
      @invalid_rows.each{ |r| @error_csv << r }
    end
    puts "Done"
  end

  private
  attr_accessor :invalid_rows, :input, :output, :field_index, :error_csv

  def get_field row
    if row.length == input.row_size
      row[@field_index]
    else
      @invalid_rows << row
      false
    end
  end

  def detect_flight row
    return false unless field = get_field(row) 
    if (field =~ /\*/ && field.length == 3) || field.length == 2
      "IATA"
    elsif field.length == 3 && field
      "ICAO"
    else
      @invalid_rows << row
      false
    end
  end
end
