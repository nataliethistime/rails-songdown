class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|

      t.string :artist
      t.string :name
      t.text :content

      t.string :key
      t.string :youtube

      t.timestamps null: false
    end
  end
end
