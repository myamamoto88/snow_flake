class SnowFlake
  class Generator
    class TimeMoveBackWardError < StandardError; end

    def id
      timestamp_ms = current_timestmap_ms

      commander.process(
        timestamp_ms: timestamp_ms,
        last_timestamp_ms: last_timestamp_ms
      )
      commander.conflate
    ensure
      timestamp_ms = fetch_next_time(timestamp_ms) if commander.wait?
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
      timestamp_ms = (Time.now.to_f * 1_000).to_i
      diff = timestamp_ms - last_timestamp_ms
      if diff.negative?
        raise TimeMoveBackWardError,
          "Refusing to generate id, because time is back (#{diff} ms)"
      end
      timestamp_ms
    end

    def fetch_next_time(timestamp_ms)
      while timestamp_ms <= last_timestamp_ms
        timestamp_ms = current_timestamp_ms
      end
      timestamp_ms
    end
  end
end
