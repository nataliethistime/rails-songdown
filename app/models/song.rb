class Song < ActiveRecord::Base
  validates  :artist, :presence => true
  validates :title, :presence => true
  validates :content, :presence => true

  def full_name
    "#{artist} - #{title}"
  end
end
