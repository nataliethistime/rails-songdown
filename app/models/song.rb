
class Song < ActiveRecord::Base
  validates :artist, :presence => true
  validates :title, :presence => true
  validates :content, :presence => true

  before_save :handle_full_name

  def self.search(query)
    if query.nil? || query.empty?
      all
    else
      where 'full_name_searchable LIKE :query', :query => "%#{query}%"
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

  def self.reset_views_count
    update_all(:views => 0)
  end

  private
    def handle_full_name
      self.full_name = "#{self.artist} - #{self.title}"
      self.full_name_searchable = "#{self.artist} #{self.title}"
    end
end
