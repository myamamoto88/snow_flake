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

    Resource = Struct.new(:last_timestamp_ms, :timestamp_ms)

    def setup(config)
      components.each do |component|
        component.setup(config)
      end
    end

    def process(resource = {})
      components.each do |component|
        component.process(
          Resource.new(
            timestamp_ms: resource[:timestamp_ms],
            last_timestamp_ms: resource[:last_timestamp_ms]
          )
        )
      end
    end

    def conflate
      shifted_bit = 0
      components.reverse.each_with_object(0) do |component, id|
        id += component.value << shifted_bit
        shifted_bit += component.bits
      end
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
