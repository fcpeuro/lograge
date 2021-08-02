require 'rails/railtie'
require 'action_view/log_subscriber'
require 'action_controller/log_subscriber'

module Lograge
  class Railtie < Rails::Railtie
    config.lograge = Lograge::OrderedOptions.new
    config.lograge.enabled = false
    config.lograge.keep_original_rails_log = true
    config.lograge.formatter = Lograge::Formatters::Json.new

    config.after_initialize do |app|
      app.config.lograge.logger = ActiveSupport::Logger.new "#{Rails.root}/log/lograge_#{Rails.env}.log"
      Lograge.setup(app) if app.config.lograge.enabled
    end
  end
end
