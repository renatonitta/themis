require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Themis
  class Application < Rails::Application
    config.generators do |g|
      g.template_engine :haml
      g.test_framework  :rspec, :fixture => true, :views => false
      g.fixture_replacement :factory_girl, :dir => "spec/support/factories"
    end

    config.encoding = "utf-8"

    config.to_prepare { 
      Devise::SessionsController.layout "admin" 
    } 

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    {:account => 'gonowlabs', :developer => true,
      :default_tab => 'popular', :color => 'grey',  
      :hide_mods => true, :num_items => 10, :show_powered_by => true
    }.each do |key, value|
      Disqus::defaults[key] = value
    end
  end
end
