require 'csv'

module Rectory
  # Write the results some test to a simple CSV file
  class CsvOutputter
    # @param results [Array] Rectory::Expectation set (with Rectory::Results)
    # @param output [String] path to the desired output CSV
    # @param options [Hash] options for CSV.open()
    # @return [nil]
    def self.write(results, output, options = {})

      CSV.open(output, "wb", options) do |csv|
        csv << [
          "url",
          "location",
          "code",
          "result_location",
          "result_code",
          "pass"
        ]

        results.each do |r|
          csv << [
            r.url,
            r.location,
            r.code,
            r.result.location,
            r.result.code,
            r.pass?
          ]
        end
      end

      nil
    end
  end
end
