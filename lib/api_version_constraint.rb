##
# Class for verification of api version.
class ApiVersionConstraint
##
# Initializa the class with options from route.
  def initialize(options)
    @apiversion = options[:apiversion]
    @default = options[:default]
  end

##
# Verify if wich version of api will be used.
  def matches?(req)
    @default || req.headers['accept'].include?("application/mycashflow-api-version:#{@apiversion}")
  end
end
