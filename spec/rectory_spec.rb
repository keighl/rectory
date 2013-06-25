require File.expand_path('../spec_helper', __FILE__)

describe Rectory do

  describe "self#verify" do
    expectations = [
      Rectory::Expectation.new("http://example.com/304/url", :location => "http://example.com/304/target", :code => 302),
      Rectory::Expectation.new("http://example.com/200", :code => 200),
      Rectory::Expectation.new("http://example.com/304", :code => 304),
      Rectory::Expectation.new("http://example.com/500", :code => 500),
    ]

    before(:each) {
      expectations.each do |e|
        stub_request(:get, e.url).
          to_return(:status => e.code, :headers => { :location => e.location })
      end
    }

    it "finds the results for each expectation" do
      x = Rectory.verify expectations
      x.each do |e|
        e.pass?.should be_true
      end
    end
  end
end