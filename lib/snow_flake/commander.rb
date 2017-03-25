class SnowFlake
  class Commander
    FORMATION = [SignBit, Timestamp, MachineId, Sequence]

    def setup(config)
      components.each do |component|
        component.setup(config)
      end
    end

    def process(timestamp_ms)
      components.each do |component|
        component.process(config)
      end
    end

    def conflate
    end

    def wait?
      components.any?(:wait)
    end

    private

    def components
      @components ||= FORMATION.map(&:new)
    end
  end
end
