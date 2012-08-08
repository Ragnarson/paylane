require "savon"
require "paylane/version"
require "paylane/gateway"
require "paylane/api"
require "paylane/response"
require "paylane/payment"
require "paylane/recurring_payment"
require "paylane/railtie" if defined?(Rails)

module PayLane
  class << self
    attr_accessor :currency, :login, :password, :logger
  end

  self.currency = "EUR"
  self.logger = Logger.new(STDOUT)
end
