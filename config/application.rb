require_relative 'boot'

require 'rails/all'

# Neo4j for graph database
require 'neo4j/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ChatApp
  #
  # Application
  #
  # @author rashid
  #
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # neo4j configuration
    config.neo4j.session_options = { basic_auth: { username: 'neo4j',
                                                   password: 'rashid' } }
    config.neo4j.session_type = :server_db
    config.neo4j.session_path = 'http://localhost:7474'
  end
end
