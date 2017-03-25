class SnowFlake
  class NoSetup < StandardError; end

  include Singleton

  class << self
    def id
      instance.id
    end

    def setup(&block)
      instance.setup(&block)
    end
  end

  def initilize
    @setup_finish = false
  end

  def setup_finish?
    @setup_finish
  end

  def id
    lock.synchronize { generator.id }
  end

  def setup(&block)
    @setup_finish = true
    config.setup(&block)
  end

  def config
    @config ||= Config.new
  end

  def generator
    @generator ||= begin
                     raise NoSetup unless setup_finish?
                     _generator = Generator.new
                     _generator.setup(config)
                     _generator
                   end
  end

  def lock
    @lock ||= Monitor.new
  end
end
