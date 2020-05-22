class DropUnecessarySetlistItemColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :setlist_items, :artist
    remove_column :setlist_items, :title
  end
end
