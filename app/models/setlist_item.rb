class SetlistItem < ActiveRecord::Base
  belongs_to :setlist
  belongs_to :song

  validates :key, :presence => true
  validates :position, :presence => true

  before_validation :handle_create_position

  def get_all_positions
    items = self.setlist.items.all.select('position')
    items.map { |item| item.position }
  end

  private

  def handle_create_position
    if !self.position
      positions = self.get_all_positions
      last_position = positions.sort.last || 0
      self.position = last_position + 1
    end
  end
end
