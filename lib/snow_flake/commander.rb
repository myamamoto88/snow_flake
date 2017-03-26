require 'snow_flake/component/base'
require 'snow_flake/component/constable'
require 'snow_flake/component/machine_id'
require 'snow_flake/component/sequence'
require 'snow_flake/component/sign_bit'
require 'snow_flake/component/timestamp'

class SnowFlake
  class Commander
    FORMATION = [
      ::SnowFlake::Component::SignBit,
      ::SnowFlake::Component::Timestamp,
      ::SnowFlake::Component::MachineId,
      ::SnowFlake::Component::Sequence
    ]

    Resource = Struct.new(:last_timestamp_ms, :timestamp_ms)

    def setup(config)
      components.each do |component|
        component.setup(config)
      end
    end

    def process(resource = {})
      non_constable_components.each do |component|
        component.process(
          Resource.new(resource[:last_timestamp_ms], resource[:timestamp_ms])
        )
      end
    end

    def conflate
      shifted_bit = 0
      components.reverse.inject(0) do |id, component|
        id += component.value << shifted_bit
        shifted_bit += component.bits
        id
      end
    end

    def wait?
      components.any?(&:wait?)
    end

    private

    def components
      @components ||= FORMATION.map(&:new)
    end

    def non_constable_components
      @non_constable_components ||= components.reject(&:const?)
    end
  end
end
