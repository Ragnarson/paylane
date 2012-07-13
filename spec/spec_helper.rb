require 'paylane'
require 'fakeweb'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.order = 'random'
  config.before(:suite) do
    module PublicTestAccount
      LOGIN = 'paylane_test_public'
      PASSWORD = 'p2y12n3t3st'
    end
  end
end

FakeWeb.allow_net_connect = false

Savon.configure do |config|
  config.raise_errors = false
  config.log = false
  config.log_level = :info
  HTTPI.log = false
end

