class SessionsController < ApplicationController

  before_filter :redirect_if_already_logged_in, :only => [:login, :login_attempt]

  def login
  end

  def login_attempt
    authorized_user = User.authenticate(params[:username], params[:login_password])

    if authorized_user
      session[:user_id] = authorized_user.id
      redirect_to :controller => 'songs', :action => 'index'
    else
      flash[:error] = 'Username or password incorrect.'
      render 'login'
    end
  end

  def logout
    reset_session
    flash[:success] = 'You have been logged out.'
    redirect_to :controller => 'lobby', :action => 'index'
  end
end
