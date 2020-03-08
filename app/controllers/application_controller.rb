class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  protected

  def ensure_user_is_admin
    if current_user && current_user.is_admin?
      return true
    else
      flash[:alert] = "You don't have permission to do that."
      redirect_to home_path
      return false
    end
  end
end
