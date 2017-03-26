class SnowFlake
  module Component
    class MachineId < Base
      class NilMachineIdOfConfig < StandardError; end

      def setup(config)
        raise NilMachineIdOfConfig if config.machine_id.nil?
        @value = config.machine_id
      end

      def bits
        10
      end

      private

      def _process(resource)
      end
    end
  end
end
