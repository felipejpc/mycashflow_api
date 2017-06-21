class ApiVersionConstraint
  def initialize(options)
    @apiversion = options[:version]  
    @default = options[:default]  
  end

  def matches?(req)
    @default || req.headers['accept'].include?("application/mycashflow-api-version:#{@apiversion}")    
  end
end