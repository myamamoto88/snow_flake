require 'singleton'
require 'forwardable'
require 'snow_flake/commander'
require 'snow_flake/config'
require 'snow_flake/generator'
require 'snow_flake/provider'

class SnowFlake
  include Singleton
  extend Forwardable

  class << self
    def id
      instance.id
    end

    def setup(&block)
      instance.setup(&block)
    end
  end

  def_delegators :provider, :id, :setup

  private

  def provider
    @provider ||= Provider.new
  end
end
