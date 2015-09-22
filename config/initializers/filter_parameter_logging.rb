# Include the authentication token in the filtered parameters
Rails.application.config.filter_parameters += [:password, :authentication_token]
