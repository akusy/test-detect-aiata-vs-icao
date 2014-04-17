require 'spec_helper'

describe CsvReader do
  let(:filepath) { 'spec/fixtures/sample_data.csv' }
  let(:csv) { [ ["10007188-1-0-0", "SKHHH", "1202", "2012-09-24"],
                ["10010106-0-1-1", "LH", "6117", "2012-10-20"] ]
              }
  let(:header) { ["id", "carrier_code", "flight_number", "flight_date"] }

  subject { described_class.new(filepath) }

  describe "#initialize" do

    it "reads csv" do
      expect(subject.file).to eq csv
    end

    it "picks csv header" do
      expect(subject.header).to eq header
    end

    it "counts csv row size" do
      expect(subject.row_size).to eq header.size
    end
  end
end
