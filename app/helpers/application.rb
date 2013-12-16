def current_user # sets current user based on session cookie, if one exists
  @current_user ||= User.get(session[:user_id]) if session[:user_id]
end
