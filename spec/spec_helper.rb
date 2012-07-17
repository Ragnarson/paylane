require 'paylane'
require 'fakeweb'
require 'helpers'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.order = 'random'
  config.include PublicTestAccount
  config.include Helpers
end

FakeWeb.allow_net_connect = false

Savon.configure do |config|
  config.raise_errors = false
  config.log = false
  config.log_level = :info
  HTTPI.log = false
end

