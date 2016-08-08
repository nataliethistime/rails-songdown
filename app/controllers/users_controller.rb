class UsersController < ApplicationController

  before_filter :save_login_state, :only => [:create, :new]

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
