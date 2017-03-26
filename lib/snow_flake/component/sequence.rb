class SnowFlake
  module Component
    class Sequence < Base
      def setup(config)
      end

      def bits
        12
      end

      def wait?
        value.zero?
      end

      private

      def _process(resource)
        if resource.last_timestamp_ms != resource.timestamp_ms
          @value = 1
        else
          @value = (value + 1) & max_bits
        end
      end
    end
  end
end
