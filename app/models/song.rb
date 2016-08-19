class Song < ActiveRecord::Base
  validates :artist, :presence => true
  validates :title, :presence => true
  validates :content, :presence => true

  def self.search(query)
    if !query.empty?
      where 'title LIKE ?', "%#{query}%"
    else
      all
    end
  end

  def full_name
    "#{artist} - #{title}"
  end
end
