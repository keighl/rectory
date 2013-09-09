require File.expand_path('../../spec_helper', __FILE__)

describe Rectory::CsvOutputter do

  let(:expectations) {
    [
      Rectory::Expectation.new("http://example.com/302/url", {
        :location => "http://example.com/302/target",
        :code     => 302,
        :result   => { :location => "http://example.com/302/target", :code => 302 }
      }),
      Rectory::Expectation.new("http://example.com/200", {
        :code     => 200,
        :result   => { :code => 200 }
      })
    ]
  }

  it "writes the CSV correctly" do
    Rectory::CsvOutputter.write expectations, "spec/support/emit_spec_csv_output.csv"
    file = File.open("spec/support/emit_spec_csv_output.csv")
    file.read.should eq(File.open("spec/support/spec_csv_output.csv").read)
    File.unlink("spec/support/emit_spec_csv_output.csv")
  end
end