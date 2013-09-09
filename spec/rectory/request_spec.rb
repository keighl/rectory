
require File.expand_path('../../spec_helper', __FILE__)

describe Rectory::Request do

  let(:request) {
    Rectory::Request.new
  }

  describe "#perform an expectation" do

    describe "with a location redirect" do

      let(:expectation) {
        Rectory::Expectation.new('http://example.com/302/url', {
          :location => 'http://example.com/302/target',
          :code => 302
        })
      }

      before(:each) {
        headers = nil
        headers = { :location => expectation.location }
        stub_request(:get, expectation.url).to_return(:status => expectation.code, :headers => headers)
      }

      it "records the response status code to result.code" do
        request.perform expectation
        expectation.result[:location].should eq(expectation.location)
      end

      it "records the response location code to result[:location]" do
        request.perform expectation
        expectation.result[:location].should eq(expectation.location)
      end
    end

    describe "without a location redirect" do

      let(:expectation) {
        Rectory::Expectation.new('http://example.com/200', :code => 200)
      }

      before(:each) {
        headers = nil
        stub_request(:get, expectation.url).to_return(:status => expectation.code)
        request.perform expectation
      }

      it "records the response status code to result.code" do
        expectation.result[:location].should eq(expectation.location)
      end

      it "records the url to result[:location]" do
        expectation.result[:location].should be_nil
      end
    end
  end
end