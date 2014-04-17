require 'spec_helper'

describe FlightSheet do
  let(:error) { "spec/tmp/error.csv" }
  let(:input) { "spec/fixtures/sample_data.csv" }
  let(:output) { "spec/tmp/test.csv" }

  let(:output_csv) { [ ["id", "carrier_code_type", "carrier_code", "flight_number", "flight_date"], 
                        ["10010106-0-1-1", "IATA", "LH", "6117", "2012-10-20"]]
                      }
  let(:error_csv) { [["10010106-0-1-1", "LHAAA", "6117", "2012-10-20"]] }

  describe "#create" do
    subject { described_class.new(input, output) }
    before do
      subject.create
      subject.instance_variable_get(:@output).file.close
    end

    it "creates output csv" do
      expect(CSV.read(output, "r")).to eq output_csv
    end

    it "creates error csv" do
      expect(CSV.read(error, "r")).to eq error_csv
    end
  end
end
