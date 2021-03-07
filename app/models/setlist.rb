# == Schema Information
#
# Table name: setlists
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#  notes      :text
#  user_id    :integer
#
class Setlist < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy, class_name: 'SetlistItem'
  validates :title, :presence => true
  decorate_with SetlistDecorator
end
