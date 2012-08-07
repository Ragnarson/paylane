require "savon"
require "paylane/version"
require "paylane/gateway"
require "paylane/api"
require "paylane/response"
require "paylane/payment"
require "paylane/railtie" if defined?(Rails)

module PayLane
  class << self
    attr_accessor :currency, :login, :password, :logger
  end

  self.currency = "EUR"
  self.login = "paylane_test_public"
  self.password = "p2y12n3t3st"
  self.logger = Logger.new(STDOUT)
end
