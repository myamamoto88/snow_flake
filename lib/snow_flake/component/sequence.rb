class SnowFlake
  module Component
    class Sequence < Base
      def setup(config)
      end

      def bits
        12
      end

      private

      def _process(timestamp_ms)
      end
    end
  end
end
