class SongDecorator
  def name(song)
    "#{song.title.strip} - #{song.artist.strip}"
  end
end
