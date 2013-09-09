require File.expand_path('../spec_helper', __FILE__)

describe Rectory do

  let(:expectations) {
    [
      Rectory::Expectation.new("http://example.com/302", :location => "http://example.com/302/target", :code => 302),
      Rectory::Expectation.new("http://example.com/200", :code => 200),
      Rectory::Expectation.new("http://example.com/304", :code => 304),
      Rectory::Expectation.new("http://example.com/500", :code => 500)
    ]
  }

  describe "self#perform" do

    before(:each) {
      expectations.each do |e|
        headers = { :location => e.location }
        stub_request(:get, e.url).to_return(:status => e.code, :headers => headers)
      end
    }

    it "finds the results for each expectation" do
      x = Rectory.perform expectations
      x.each do |e|
        e.pass?.should be_true
      end
    end
  end
end