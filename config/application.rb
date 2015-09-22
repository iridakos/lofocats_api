require File.expand_path('../boot', __FILE__)

require "rails"

require "active_model/railtie"
#require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
#require "action_mailer/railtie"
#require "action_view/railtie"

Bundler.require(*Rails.groups)

module LofoCatsApi
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true

    config.autoload_paths << Rails.root.join('lib') << Rails.root.join('lib/validators')
  end
end
