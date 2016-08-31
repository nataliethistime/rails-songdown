class AddSetlistItemPositionColumn < ActiveRecord::Migration
  def change
    change_table :setlist_items do |t|
      t.integer :position
    end
  end
end
