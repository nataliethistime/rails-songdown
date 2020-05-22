class Setlist < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy, class_name: 'SetlistItem'
  validates :title, :presence => true
end
