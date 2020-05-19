# frozen_string_literal: true

require 'benchmark'

# :no-doc:
module Domain
  # Class responsible for verify the health of the application and its dependencies
  class Healthcheck
    class << self
      def call
        {
          version: 1,
          git_tag: GIT_TAG,
          services: {
            database: try { DB.test_connection }
          }
        }
      end

      private

      def try
        {
          status: :ok,
          time: response_time { yield }
        }
      rescue StandardError
        { status: :not_ok }
      end

      def response_time
        to_milliseconds(Benchmark.realtime { yield })
      end

      def to_milliseconds(time)
        (time * 1000).round(2)
      end
    end
  end
end
