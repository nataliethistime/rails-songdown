class SetlistItem < ActiveRecord::Base
  belongs_to :setlist

  validates :artist, :presence => true
  validates :key, :presence => true
  validates :song_id, :presence => true
  validates :title, :presence => true
  validates :position, :presence => true

  def full_name
    "#{artist} - #{title}"
  end
end
