require File.expand_path('../../spec_helper', __FILE__)

describe Rectory::Expectation do

  it "complains when you don't provide an URL" do
    lambda {
      Rectory::Expectation.new(nil)
    }.should raise_error(ArgumentError)
  end

  describe "#pass?" do

    it "performs request is there is no result object yet" do
      e = Rectory::Expectation.new("http://google.com", :location => "http://www.google.com", :code => 301)
      e.should_receive(:perform).and_return true
      e.pass?
    end

    describe "yes" do
      it "when the status code and location match" do
        e        = Rectory::Expectation.new("http://google.com", :location => "http://www.google.com", :code => 301)
        e.result = { :location => "http://www.google.com", :code => 301 }
        e.pass?.should be_true
      end
    end

    describe "no" do
      it "when the status code doesn't match the outcome" do
        e        = Rectory::Expectation.new("http://google.com", :code => 200)
        e.result = { :code => 304 }
        e.pass?.should be_false
      end

      it "when the location doesn't match the outcome" do
        e        = Rectory::Expectation.new("http://google.com", :location => "http://www.google.com", :code => 200)
        e.result = { :code => 304, :location => "http://lolcats.biz" }
        e.pass?.should be_false
      end
    end
  end
end