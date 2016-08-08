class UsersController < ApplicationController

  before_filter :authenticate_user, :except => [:new]
  before_filter :redirect_if_already_logged_in, :only => [:create, :new]

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to '/'
    else
      render 'new'
    end
  end

  def new
    @user = User.new
  end

  def profile
  end

  def setting
  end

  private
    def user_params
      params.require(:user).permit(
        :username,
        :email,
        :email_confirmation,
        :password,
        :password_confirmation
      )
    end
end
