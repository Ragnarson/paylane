require "savon"
require "paylane/version"
require "paylane/gateway"
require "paylane/api"
require "paylane/response"
require "paylane/configuration"
require "paylane/customer"
require "paylane/railtie" if defined?(Rails)

module PayLane
  def self.logger
    @logger ||= Logger.new(STDOUT)
  end

  def self.logger=(logger)
    @logger = logger
  end
end
