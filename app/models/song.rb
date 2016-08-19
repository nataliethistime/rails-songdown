class Song < ActiveRecord::Base
  validates :artist, :presence => true
  validates :title, :presence => true
  validates :content, :presence => true

  def self.search(query)
    if query.empty?
      all
    else
      where 'artist LIKE :query OR title LIKE :query', :query => "%#{query}%"
    end
  end

  def full_name
    "#{artist} - #{title}"
  end
end
