class SnowFlake
  module Component
    class Base
      class InvalidValueError < StandardError; end

      def setup(config)
        raise NotImplementedError
      end

      def process(timestamp_ms)
        _process(timestamp_ms)
        raise InvalidValueError unless valid?
      end

      def bits
        raise NotImplementedError
      end

      def max_bits
        -1 ^ (-1 << bits)
      end

      def value
        @value ||= 0
      end

      def wait?
        false
      end

      protected

      def _process(timestamp_ms)
        raise NotImplementedError
      end

      def valid?
        0 <= value && value <= max_bits
      end
    end
  end
end
