class UsersController < ApplicationController
  def home
    @top_songs = Song.accessible_by(current_ability).top_songs
    @new_songs = Song.accessible_by(current_ability).new_songs
  end

  def settings
  end
end
