HealthCheck.setup do |config|
  # uri prefix (no leading slash)
  config.uri = 'api/health'

  # Text output upon success
  config.success = 'OK'

  # Run checks from middleware to exclude database checking
  config.middleware_checks = ['middleware', 'standard']

  # You can customize which checks happen on a standard health check
  config.standard_checks = ['middleware']

  # You can set what tests are run with the 'full' or 'all' parameter
  config.full_checks = ['database', 'migrations', 'cache']

  ### Unreleased and added in https://github.com/ianheggie/health_check/pull/72
  ## Disable the error message to prevent /api/health from leaking
  ## sensitive information
  #config.include_error_in_response_body = false
end
