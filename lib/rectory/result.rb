module Rectory

  # Encapulates the results of an HTTP test.
  #
  # @attr location The HTTP 'Location' header of the response
  # @attr code The HTTP status code of the response
  class Result

    RESULT_DEFAULTS = {
      :location => nil,
      :code     => 0
    }

    attr_accessor :location, :code

    def initialize(args = {})
      args = RESULT_DEFAULTS.merge args

      self.location = args[:location]
      self.code     = args[:code].to_i
    end
  end
end
