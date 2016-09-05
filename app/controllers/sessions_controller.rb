class SessionsController < ApplicationController

  before_filter :redirect_if_already_logged_in, :except => [:destroy]

  def create
    authorized_user = User.authenticate(params[:username], params[:login_password])

    if authorized_user
      flash.clear
      session[:user_id] = authorized_user.id
      redirect_to home_path
    else
      flash[:error] = 'Username or password incorrect.'
      render :template => 'lobby/index'
    end
  end

  def destroy
    reset_session
    flash[:success] = 'You have been logged out.'
    redirect_to root_path
  end
end
