require 'spec_helper'

describe CsvCreator do
  let(:header){ ["id", "carrier_code", "flight_date"] }
  let(:filepath) { "spec/tmp/test.csv" }
  let(:expectation) { ["id", "carrier_code_type", "carrier_code", "flight_date"] }

  subject { described_class.new(header, filepath) }

  describe "#initialize" do
    it "opens new csv with header" do
      subject.file.close
      expect(CSV.read(filepath, "r")).to eq [expectation]
    end
  end

  describe "#get_output_header" do

    it "creates output file header" do
      expect(subject.get_output_header(header)).to eq expectation
    end
  end
end
