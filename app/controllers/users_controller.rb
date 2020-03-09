class UsersController < ApplicationController
  def home
    @top_songs = Song.accessible_by(current_ability).top_songs
    @new_songs = Song.accessible_by(current_ability).new_songs
  end

  def settings
  end

  def update
    current_user.update user_params

    if current_user.save
      flash[:notice] = 'Settings saved'
      redirect_to settings_path
    else
      render 'settings'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
