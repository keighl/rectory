require 'open-uri'
require 'net/http'
require 'celluloid'

module Rectory

  # Test the expectated results of an HTTP request
  class Request
    include Celluloid

    # Test the expectated results of an HTTP request
    #
    # @param expectation [Rectory::Expectation] the expectation you're testing
    # @return [Rectory::Expectation] the same expectation with result attributes updated
    def perform(expectation)
      uri = URI expectation.url
      req = Net::HTTP::Get.new uri.request_uri

      res = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request req
      end

      expectation.result[:location] = res['location']
      expectation.result[:code]     = res.code.to_i

      return expectation
    end
  end
end
