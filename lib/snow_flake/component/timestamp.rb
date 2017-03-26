class SnowFlake
  module Component
    class Timestamp < Base
      class NilGenrationStartTimeOfConfig < StandardError; end

      def setup(config)
        raise NilGenrationStartTimeOfConfig if config.generation_start_time.nil?
        @generation_start_time_ms = config.generation_start_time.to_i * 1_000
      end

      def bits
        41
      end

      private

      attr_reader :generation_start_time_ms

      def _process(resource)
        @value = resource.timestamp_ms - generation_start_time_ms
      end
    end
  end
end
