class CsvCreator < CsvBase
  attr_accessor :file, :header, :mapper

  def initialize header, output_file
    self.header = get_output_header header
    self.file = build_csv output_file, @header
    self.mapper = generate_map @header
  end

  def get_output_header header
    Array.new(header).insert(1, "carrier_code_type")
  end
end
