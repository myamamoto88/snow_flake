class SnowFlake
  module Component
    class MachineId < Base
      def setup(config)
      end

      def bits
        10
      end

      private

      def _process(timestamp_ms)
      end
    end
  end
end
