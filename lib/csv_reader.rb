class CsvReader < CsvBase
  attr_accessor :file, :header, :mapper, :row_size

  def initialize input
    self.file = read_csv input
    self.header = @file.shift
    self.mapper = generate_map @header
    self.row_size = @header.size
  end

  private

  def read_csv input
    begin
      CSV.read input
    rescue => e
      abort "ERROR: Incorrect input filename. #{e}"
    end
  end
end
