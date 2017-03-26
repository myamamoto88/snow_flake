class SnowFlake
  class Provider
    class NoSetup < StandardError; end

    def initialize
      @setup_finish = false
    end

    def id
      lock.synchronize { generator.id }
    end

    def setup(&block)
      @setup_finish = true
      config.setup(&block)
      generator.setup(config)
    end

    private

    def setup_finish?
      @setup_finish
    end

    def config
      @config ||= Config.new
    end

    def generator
      @generator ||= begin
                       raise NoSetup unless setup_finish?
                       Generator.new
                     end
    end

    def lock
      @lock ||= Monitor.new
    end
  end
end
