require 'spec_helper'

describe CsvBase do  
  let(:header){ ["id", "carrier_code", "flight_date"] }

  subject { described_class.new }
  
  describe "#generate_map" do
    let(:expectation) { {"id"=>0, "carrier_code"=>1, "flight_date"=>2} }
    
    it "creates Hash from header array" do
      expect(subject.generate_map(header)).to eq expectation
    end
  end

  describe "#build_csv" do
    let(:filepath) { "spec/tmp/test.csv" }

    it "opens new csv with header" do
      subject.build_csv(filepath, header).close
      expect(CSV.read(filepath, "r")).to eq [header]
    end
  end
end
