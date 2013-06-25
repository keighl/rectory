module Rectory

  # The expectations for an HTTP request.
  #
  # @attr code The expected HTTP status code. (200, 302, 304, 404, 400, etc)
  # @attr location The expected HTTP `Location` header, or the end location of a redirect. Should be `nil` if the expectation is not a redirect (200, 304, 404, etc)
  # @attr url The URL to test
  # @attr result A Rectory::Result instance which contains HTTP repsonse details
  class Expectation

    EXPECTATION_DEFAULTS = {
      :location => nil,
      :code     => 200
    }

    attr_accessor :url, :location, :code, :result

    # @param url [String] The URL against which to test an HTTP reponse
    # @param args [Hash] A hash of HTTP response expectations (`:code`, `:location`)
    def initialize(url, args = {})
      raise ArgumentError, "You must provide a URL to test!" if url.nil?

      args = EXPECTATION_DEFAULTS.merge args

      self.url = url
      self.code     = args[:code].to_i
      self.location = url
      self.location = args[:location] unless args[:location].nil?

      if args[:result].nil?
        self.result = Rectory::Result.new
      else
        raise ArgumentError, ":result must be an instance of Rectory::Result" unless args[:result].is_a?(Rectory::Result)
        self.result = args[:result]
      end
    end

    # Determines whether the HTTP result satifies the expectations
    #
    # Verifies that both status code and location match
    #
    # @return [Boolean]
    def pass?
      truths = []
      truths << (result.location.to_s.gsub(/\/$/, "") == location.to_s.gsub(/\/$/, ""))
      truths << (result.code == code.to_i) unless code.nil?
      truths.all?
    end

    # Run self through Rectory::Verfier#verify
    #
    # Updates the `result` attribute
    def verify
      v           = Rectory::Verifier.new
      r           = v.verify self
      nil
    end
  end
end
