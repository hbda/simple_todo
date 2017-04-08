require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SimpleTodo
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths += Dir["#{config.root}/app/**/"]

    config.i18n.default_locale = :ru

    config.generators do |generate|
      # generate.fixture_replacement :factory_girl, dir: 'spec/factories'
      generate.helper false
      generate.stylesheets false
      generate.javascripts false
      generate.test_framework :rspec
      generate.view_specs false
    end
  end
end
