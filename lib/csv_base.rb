class CsvBase  
  def generate_map header
    Hash[header.map.with_index { |x, i| [x, i] }]
  end

  def build_csv output, header
    begin
    CSV.open(output, 'w') << header
    rescue => e
      puts "Write error. #{e}"
    end
  end
end
