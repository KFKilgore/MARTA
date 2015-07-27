require File.expand_path('../boot', __FILE__)

require "rails"


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MARTAapp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.active_record.raise_in_transactional_callbacks = true
  end
  
  #Create a place to store information for the duration of the session
  MARTAapp:Application.configure do
    require 'open-uri'
    require 'json'
    
    config stations = []
    results = JSON.parse(open("http://developer.itsmarta.com/BRDRestService/BRDRestService.svc/GetAllBus").read)
    results.each do |MARTAdata|
      config.stations.push(MARTAdata["TIMEPOINT"])
    end
    config.stations.uniq!
    config.stations.sort!
  end
end


