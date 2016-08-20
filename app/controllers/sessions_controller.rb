class SessionsController < ApplicationController

  before_filter :redirect_if_already_logged_in, :except => [:destroy]

  def new
  end

  def create
    authorized_user = User.authenticate(params[:username], params[:login_password])

    if authorized_user
      session[:user_id] = authorized_user.id
      redirect_to home_path
    else
      flash[:error] = 'Username or password incorrect.'
      render 'new'
    end
  end

  def destroy
    reset_session
    flash[:success] = 'You have been logged out.'
    redirect_to :controller => 'lobby', :action => 'index'
  end
end
