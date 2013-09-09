module Rectory

  # The expectations for an HTTP request.
  #
  # @attr code The expected HTTP status code. (200, 302, 304, 404, 400, etc)
  # @attr location The expected HTTP `Location` header, or the end location of a redirect. Should be `nil` if the expectation is not a redirect (200, 304, 404, etc)
  # @attr url The URL to test
  # @attr result A Rectory::Result instance which contains HTTP repsonse details
  class Expectation

    attr_accessor :url, :location, :code, :result

    # @param url [String] The URL against which to test an HTTP reponse
    # @param args [Hash] A hash of HTTP response expectations (`:code`, `:location`)
    def initialize(url, args = {})
      raise ArgumentError, "You must provide a URL to test!" if url.nil?

      defaults = {
        :code   => 200,
        :result => {}
      }

      args          = defaults.merge args
      self.url      = url
      self.code     = args[:code].to_i
      self.result   = args[:result]
      self.location = args[:location]
    end

    # Determines whether the HTTP result satifies the expectations
    #
    # Verifies that both status code and location match
    #
    # @return [Boolean]
    def pass?
      perform if result.empty?
      truths = []
      truths << (result[:location].to_s.gsub(/\/$/, "") == location.to_s.gsub(/\/$/, ""))
      truths << (result[:code] == code.to_i) unless code.nil?
      truths.all?
    end

    private

    # Run self through Rectory::Verfier#perform
    #
    # Updates the `result` attribute
    def perform
      v = Rectory::Request.new
      r = v.perform self
      nil
    end
  end
end
