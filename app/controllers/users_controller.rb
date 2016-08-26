class UsersController < ApplicationController

  before_filter :authenticate_user, :except => [:create]
  before_filter :redirect_if_already_logged_in, :only => [:create]

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'Successfully created account - please sign in.'
      redirect_to '/'
    else
      render :template => 'lobby/register'
    end
  end

  def home
    @top_songs = Song.all.order(:views => :desc).limit(10)
    @new_songs = Song.all.order(:created_at => :desc).limit(10)
  end

  def settings
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
