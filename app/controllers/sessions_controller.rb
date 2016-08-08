class SessionsController < ApplicationController

  before_filter :authenticate_user, :only => [:home, :profile, :setting]
  before_filter :save_login_state, :only => [:login, :login_attempt]

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
    session[:user_id] = nil
    flash[:success] = 'You have been logged out.'
    redirect_to :action => 'login'
  end

  def profile
  end

  def setting
  end
end
