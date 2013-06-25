
require File.expand_path('../../spec_helper', __FILE__)

describe Rectory::Verifier do

  let(:verifier) {
    Rectory::Verifier.new
  }

  describe "#verify an expectation" do

    describe "with a location redirect" do

      let(:expectation) {
        Rectory::Expectation.new('http://example.com/302/url', :location => 'http://example.com/302/target', :code => 302)
      }

      before(:each) {
        headers = nil
        headers = { :location => expectation.location }
        stub_request(:get, expectation.url).to_return(:status => expectation.code, :headers => headers)
        verifier.verify expectation
      }

      it "records the response status code to result.code" do
        expectation.result.location.should eq(expectation.location.to_s)
      end

      it "records the response location code to result.location" do
        expectation.result.location.should eq(expectation.location.to_s)
      end
    end

    describe "without a location redirect" do

      let(:expectation) {
        Rectory::Expectation.new('http://example.com/200', :code => 200)
      }

      before(:each) {
        headers = nil
        stub_request(:get, expectation.url).to_return(:status => expectation.code)
        verifier.verify expectation
      }

      it "records the response status code to result.code" do
        expectation.result.location.should eq(expectation.location.to_s)
      end

      it "records the url to result.location" do
        expectation.result.location.should eq(expectation.url.to_s)
      end
    end
  end
end