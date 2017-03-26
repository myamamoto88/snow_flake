require 'snow_flake/component/base'
require 'snow_flake/component/machine_id'
require 'snow_flake/component/sequence'
require 'snow_flake/component/sign_bit'
require 'snow_flake/component/timestamp'

class SnowFlake
  class Commander
    FORMATION = [
      ::SnowFlake::Component::MachineId,
      ::SnowFlake::Component::Sequence,
      ::SnowFlake::Component::SignBit,
      ::SnowFlake::Component::Timestamp
    ]

    def setup(config)
      components.each do |component|
        component.setup(config)
      end
    end

    def process(timestamp_ms)
      components.each do |component|
        component.process(timestamp_ms)
      end
    end

    def conflate
    end

    def wait?
      components.any?(&:wait?)
    end

    private

    def components
      @components ||= FORMATION.map(&:new)
    end
  end
end
