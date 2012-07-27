module PayLane
  class Railtie < ::Rails::Railtie
    initializer 'paylane.rails_logger' do
      PayLane.logger = Rails.logger
    end
  end
end
