require File.expand_path('../../spec_helper', __FILE__)

describe Rectory::Expectation do

  it "complains when you don't provide an URL" do
    lambda {
      Rectory::Expectation.new(nil)
    }.should raise_error(ArgumentError)
  end

  it "requires :result to be an instance of Rectory::Result, if supplied as an option" do
    lambda {
      Rectory::Expectation.new("http://google.com", :result => "gummies")
    }.should raise_error(ArgumentError)
  end

  it "sets location to url if location is left nil" do
    e = Rectory::Expectation.new("http://google.com")
    e.location.should eq(e.url)
  end

  describe "#pass?" do
    describe "yes" do
      it "when the status code and location match" do
        e        = Rectory::Expectation.new("http://google.com", :location => "http://www.google.com", :code => 302)
        e.result = Rectory::Result.new(:location => "http://www.google.com", :code => 302)
        e.pass?.should be_true
      end
    end

    describe "no" do
      it "when the status code doesn't match the outcome" do
        e        = Rectory::Expectation.new("http://google.com", :code => 200)
        e.result = Rectory::Result.new(:code => 304)
        e.pass?.should be_false
      end

      it "when the location doesn't match the outcome" do
        e        = Rectory::Expectation.new("http://google.com", :location => "http://www.google.com", :code => 200)
        e.result = Rectory::Result.new(:code => 304, :location => "http://lolcats.biz")
        e.pass?.should be_false
      end
    end
  end

  describe "#verify" do
    it "should run Rectory::Verifier#verify with self" do
      e = Rectory::Expectation.new("http://google.com", :location => "http://www.google.com", :code => 302)

      stub_request(:get, e.url).
        to_return(:status => e.code, :headers => { :location => e.location })

      v = Rectory::Verifier.new
      Rectory::Verifier.should_receive(:new).and_return(v)
      v.should_receive(:verify).with(e).and_call_original
      e.verify
    end
  end
end