class SnowFlake
  module Component
    class SignBit < Base
      POSITIVE_BIT = 0

      def setup(config)
        @value = POSITIVE_BIT
      end

      def bits
        1
      end

      private

      def _process(timestamp_ms)
      end
    end
  end
end
