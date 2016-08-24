class RenameSongYoutubeColumn < ActiveRecord::Migration
  def change
    rename_column :songs, :youtube, :youtube_url
  end
end
