class IncrementSongViewCounterJob < ActiveJob::Base
  queue_as :default

  def perform(song_id)
    song = Song.find song_id

    if song.views
      song.views = song.views.to_i + 1
    else
      song.views = 1
    end

    song.save
  end
end
