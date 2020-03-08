class UsersController < ApplicationController
  def home
    @top_songs = Song.top_songs
    @new_songs = Song.new_songs
  end

  def settings
  end
end
