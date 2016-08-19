class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
    def handle_not_logged_in
      reset_session
      flash[:error] = 'You need to be logged in to view that page.'
      redirect_to root_path
      return false
    end

    def authenticate_user
      if session[:user_id]
        begin
          @current_user = User.find session[:user_id]
          return true
        rescue ActiveRecord::RecordNotFound
          handle_not_logged_in
        end
      else
        handle_not_logged_in
      end
    end

    def ensure_user_is_admin
      if @current_user && @current_user.is_admin?
        return true
      else
        redirect_to :controller => 'songs', :action => 'index'
        return false
      end
    end

    def ensure_user_is_editor
      if @current_user && @current_user.is_editor?
        return true
      else
        redirect_to :controller => 'songs', :action => 'index'
        return false
      end
    end

    def redirect_if_already_logged_in
      if session[:user_id]
        redirect_to :controller => 'songs', :action => 'index'
        return false
      else
        return true
      end
    end
end