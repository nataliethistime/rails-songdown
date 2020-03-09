class Setlist < ActiveRecord::Base
  belongs_to :user
  has_many :setlist_items, :dependent => :destroy

  validates :title, :presence => true
end
