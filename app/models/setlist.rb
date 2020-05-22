class Setlist < ActiveRecord::Base
  belongs_to :user
  has_many :setlist_items, :dependent => :destroy
  alias items setlist_items
  validates :title, :presence => true
end
