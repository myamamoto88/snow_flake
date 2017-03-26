class SnowFlake
  class Config
    attr_accessor :generation_start_time, :machine_id

    def setup(&block)
      instance_eval(&block)
    end
  end
end
