class CreateSetlistItems < ActiveRecord::Migration
  def change
    create_table :setlist_items do |t|

      t.timestamps null: false

      t.integer :song_id

      t.string :artist
      t.string :key
      t.string :title
    end
  end
end
