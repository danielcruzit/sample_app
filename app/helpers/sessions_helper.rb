module SessionsHelper

  # Logs in the given user.
  def log_in(user) 
    session[:user_id] = user.id
  end

  # Logs out the current user. def log_out
  def log_out
    session.delete(:user_id)
    @current_user = nil
 end

    # Returns the current logged-in user (if any).
  def current_user
    if session[:user_id]
        #pretty much means if the @ doesn't have the value it goes get it
        @current_user ||= User.find_by(id: session[:user_id]) 
    end
  end
  
    # checks if there is any user logged in
    def logged_in?
         !current_user.nil?
    end

    def current_user?(user)
      user && user == current_user
    end

  # Redirects to stored location (or to the default). def redirect_back_or(default)
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url) 
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

end


