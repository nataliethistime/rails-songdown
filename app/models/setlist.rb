class Setlist < ActiveRecord::Base
  belongs_to :user
  has_many :setlist_items

  validates :title, :presence => true
  validates :date, :presence => true

end
