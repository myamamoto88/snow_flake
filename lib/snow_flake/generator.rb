class SnowFlake
  class Generator
    def id
      timestamp_ms = current_timestmap_ms

      commander.process(timestamp_ms)
      commander.conflate
    ensure
      wait_for_next_time(timestamp_ms) if commander.wait?
      @last_timestamp_ms = timestamp_ms
    end

    def setup(config)
      commander.setup(config)
    end

    private

    def commander
      @commander ||= Commander.new
    end

    def last_timestamp_ms
      @last_timestamp_ms ||= 0
    end

    def current_timestmap_ms
    end

    def wait_for_next_time(timestamp_ms)
    end
  end
end
