require 'spec_helper'

describe CsvParser do
  let(:input) { Struct.new(:mapper, :row_size, :header).new({ "carrier_code" => 1 }, 4, []) }
  let(:output) { Struct.new(:mapper).new({ "carrier_code_type" => 1 }) }
  let(:row) { ["10010106-0-1-1","LH","6117","2012-10-20"] }
  let(:invalid_row) { ["10010106-0-1-1","LHAAA","6117","2012-10-20"] }
  let(:valid_row) { ["10010106-0-1-1", "IATA", "LH", "6117", "2012-10-20"] }

  describe "#parse_row" do

    subject { described_class.new(input, output) }

    it "returns new valid row" do
      expect(subject.parse_row(row)).to eq valid_row
    end

    context "When row is invalid" do
      it "returns nil" do
        expect(subject.parse_row(invalid_row)).to be_nil
      end

      it "puts invalid row to invalid_rows array" do
        subject.parse_row(invalid_row)

        expect(subject.instance_variable_get(:@invalid_rows)).to eq [invalid_row]
      end
    end
  end

  describe "#close" do
    subject { described_class.new(input, output) }

    context "When no invalid rows" do
      it "puts Done in cli" do
        expect(subject).to receive(:puts){ "Done" }
        subject.close
      end
    end

    context "When there are invalid rows" do
      let(:filepath) { "spec/tmp/error.csv" }

      before { subject.stub(:build_csv).and_return(CSV.open(filepath, 'w')) }

      it "creates error.csv and writes invalid rows there" do
        subject.parse_row(invalid_row)
        subject.close
        subject.instance_variable_get(:@error_csv).close

        expect(CSV.read(filepath, "r")).to eq [invalid_row]
      end
    end
  end
end
