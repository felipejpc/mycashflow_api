##
# Module for auth control.
module Authenticable
##
# Get the current user via auth token passed in http request
  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

##
# Verify authorization for access
  def authenticate_with_token!
    render json: { errors: 'Unauthorized access!' }, status: 401 unless user_logged_in?
  end

##
# Verify if exist a logged user
  def user_logged_in?
    current_user.present?
  end
end
