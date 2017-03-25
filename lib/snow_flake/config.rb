class SnowFlake
  class Config
    attr_accessor :generation_start_time, :machine_id

    def setup(&block)
      instance_eval(&block)
    end

    def generation_start_time_ms
      generation_start_time.to_i * 1_000
    end
  end
end
