class ApiVersionConstraint
  def initialize(options)
    @apiversion = options[:apiversion]
    @default = options[:default]
  end

  def matches?(req)
    @default || req.headers['accept'].include?("application/mycashflow-api-version:#{@apiversion}")
  end
end
