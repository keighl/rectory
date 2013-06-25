require 'rectory/version'
require 'rectory/verifier'
require 'rectory/csv_outputter'
require 'rectory/expectation'
require 'rectory/result'

Celluloid.logger = nil

module Rectory

  DEFAULT_CELLULOID_OPTIONS = {
    :pool => 10
  }

  # Test the expectated results of an some HTTP requests
  #
  # Utilizes celluloid pooling futures for speed.
  #
  # @param expectations [Array] a `Rectory::Expectation` set you're testing
  # @param options [Hash] Celluloid `pool()` options
  # @return [Array] the same set of expectations with result attibutes updated
  def self.verify(expectations, options = {})
    options = DEFAULT_CELLULOID_OPTIONS.merge options
    pool    = Rectory::Verifier.pool(options)
    futures = expectations.map { |e| pool.future(:verify, e) }
    results = futures.map(&:value)
  end
end
