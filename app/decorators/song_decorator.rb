module SongDecorator
  extend self
  def name(song)
    "#{song.title.strip} - #{song.artist.strip}"
  end
end
