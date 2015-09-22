# Simple constraint to match the desired API version in the routes
class ApiConstraints
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  # Resolve if the given request matches this version or reached the default version
  def matches?(req)
    @default || req.headers['Accept'].include?("application/vnd.lofocats.v#{@version}")
  end
end