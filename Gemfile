source 'https://rubygems.org'

# Rails
gem 'rails', '~>4.2'
# Database
gem 'pg', '~> 0.18'

# Required to use 'has_secure_password' in ActiveRecord
gem 'bcrypt'

# Serializers for the JSON responses
gem 'active_model_serializers'

# Used for API authorization
gem 'cancan'

# Send logs to SDTOUT
gem 'rails_12factor'

# Health check endpoint
gem 'health_check'

# Collect and export monitoring metrics
gem 'prometheus-client'

group :test do
  # Rspec
  gem 'rspec-rails', '>= 3.4.4', '< 4.0'
  # FactoryGirl factories
  gem "factory_girl_rails"
  # Use should matchers
  gem 'shoulda-matchers', require: false
  # To better handle time sensitive tests
  gem 'timecop'
end
