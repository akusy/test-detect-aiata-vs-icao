require 'spec_helper'

describe FlightClassifier do
  describe "#start" do
    context "When no arguments" do
      subject { described_class.new }
      let(:expectation){ "Wrong number of arguments (0 for 2). Type '--help' to get more information" }

      it "prints info" do
        expect(subject).to receive(:puts){ expectation }
        subject.start
      end
    end

    context "When user types --help" do
      subject { described_class.new(['--help']) }
      let(:expectation){ "Usage: ./start.rb or ruby start.rb \n  --help" }

      it "prints help info" do
        expect(subject).to receive(:puts){ include(expectation) }
        subject.start
      end
    end

    context "When input filename is incorrect" do
      subject { described_class.new(['wrong.csv', 'output.csv']) }
      let(:expectation){ "ERROR: Incorrect input filename. No such file or directory @ rb_sysopen - wrong.csv" }

      it "prints error info" do
        expect(lambda { subject.start }).to raise_error(SystemExit, expectation)
      end
    end

    context "When input filename is incorrect" do
      subject { described_class.new(['spec/fixtures/sample_data.csv', 'output.csv']) }

      it "start classifying" do
        expect(subject).to receive(:classify)
        subject.start
      end
    end
  end
end
