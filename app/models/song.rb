
require 'songdown_compiler'

class Song < ActiveRecord::Base
  validates :artist, :presence => true
  validates :title, :presence => true
  validates :content, :presence => true

  def self.search(query)
    if query.nil? || query.empty?
      all
    else
      where 'artist LIKE :query OR title LIKE :query', :query => "%#{query}%"
    end
  end

  def self.build_songlist(songs)
    # A `songlist` is an object of the form "Artist name => array of songs"
    songlist = {}

    songs.each do |song|
      songlist[song.artist] ||= []
      songlist[song.artist].push song
    end

    songlist
  end

  def full_name
    "#{artist} - #{title}"
  end

  def to_html
    songdown_song = SongdownCompiler.new content
    songdown_song.parse
    songdown_song.to_html
  end
end
