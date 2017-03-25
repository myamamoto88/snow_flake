class SnowFlake
  module Component
    class Timestamp < Base
      attr_reader :generation_start_time_ms

      def setup(config)
      end

      def bits
        41
      end

      private

      def _process(timestamp_ms)
      end
    end
  end
end
