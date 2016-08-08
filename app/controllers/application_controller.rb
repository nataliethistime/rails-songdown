class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
    def authenticate_user
      if session[:user_id]
        @current_user = User.find session[:user_id]
        return true
      else
        flash[:error] = 'You need to be logged in to view that page.'
        redirect_to root_path
        return false
      end
    end

    def save_login_state
      if session[:user_id]
        redirect_to :controller => 'sessions', :action => 'home'
        return false
      else
        return true
      end
    end
end
